# Copyright 2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

DB_VER="4.8"

inherit base bash-completion-r1 db-use autotools eutils versionator user systemd

MY_PN="dash"

DESCRIPTION="Dash crypto-currency p2p network daemon"
HOMEPAGE="https://www.dashpay.io/"
SRC_URI="https://github.com/dashpay/${MY_PN}/archive/v${PV}.zip -> ${MY_PN}-${PV}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples libressl logrotate systemd upnp +wallet"

RDEPEND="
	dev-libs/boost[threads(+)]
	!libressl? ( dev-libs/openssl:0[-bindist] )
	libressl? ( dev-libs/libressl )
	logrotate? (
		app-admin/logrotate
	)
	upnp? (
		net-libs/miniupnpc
	)
	sys-libs/db:$(db_ver_to_slot "${DB_VER}")[cxx]
	>=dev-libs/leveldb-1.18-r1
	dev-libs/libsecp256k1
"
DEPEND="${RDEPEND}
	dev-lang/yasm
	>=app-shells/bash-4.1
"

S="${WORKDIR}/${MY_PN}-${PV}"

pkg_setup() {
	local UG="${MY_PN}"
	enewgroup "${UG}"
	enewuser "${UG}" -1 -1 /var/lib/${MY_PN} "${UG}"
}

src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	epatch "${FILESDIR}"/${PVM}-sys_libsecp256k1.patch
	eautoreconf
	rm -r src/leveldb src/secp256k1
}

src_configure() {
	local my_econf=
	hasq test $FEATURES && my_econf="${my_econf} --enable-tests"
	CXXFLAGS+=" -I. -I$(db_includedir "${DB_VER}")"
	econf --with-gui=no \
		  --without-libs \
		  --without-utils \
		  --with-system-leveldb \
		  --with-system-libsecp256k1 \
		$(use_enable wallet) \
		$(use_with upnp miniupnpc) \
		$(use_with libressl) \
		${my_econf}
}

src_install() {
	base_src_install

	local UG="${MY_PN}"

	insinto /etc/${MY_PN}
	doins contrib/debian/examples/${MY_PN}.conf
	fowners ${UG}:${UG} /etc/${MY_PN}/${MY_PN}.conf
	fperms 600 /etc/${MY_PN}/${MY_PN}.conf

	newconfd contrib/init/dashd.openrcconf ${PN}
	newinitd contrib/init/dashd.openrc ${PN}
	use systemd && systemd_dounit contrib/init/${PN}.service

	keepdir /var/lib/${MY_PN}/.${MY_PN}

	doman contrib/debian/manpages/{${PN}.1,${MY_PN}.conf.5}

	newbashcomp contrib/${PN}.bash-completion ${PN}

	if use examples; then
		docinto examples
		dodoc -r contrib/{bitrpc,linearize,qos,spendfrom}
	fi

	if use logrotate; then
		insinto /etc/logrotate.d
		newins "${FILESDIR}"/${PN}.logrotate ${PN}
	fi
}
