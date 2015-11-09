# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DB_VER="4.8"

inherit db-use eutils systemd user

MY_PV="${PV/_/ppc.}"
MY_PN="ppcoin"
MY_P="${MY_PN}-${MY_PV}"

DESCRIPTION="Peercoin crypto-currency p2p network daemon"
HOMEPAGE="http://peercoin.net/"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/v${MY_PV}.zip -> ${P}.zip"

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cpu_flags_x86_sse2 examples ipv6 logrotate systemd upnp"

RDEPEND="
	dev-libs/boost[threads(+)]
	dev-libs/openssl:0[-bindist]
	logrotate? (
		app-admin/logrotate
	)
	upnp? (
		net-libs/miniupnpc
	)
	sys-libs/db:$(db_ver_to_slot "${DB_VER}")[cxx]
"
DEPEND="${RDEPEND}
	>=app-shells/bash-4.1
	sys-apps/sed
"

S="${WORKDIR}/${MY_P}"

pkg_setup() {
	local UG="${MY_PN}"
	enewgroup "${UG}"
	enewuser "${UG}" -1 -1 /var/lib/ppcoin "${UG}"
}

src_prepare() {
	if has_version '>=dev-libs/boost-1.52'; then
		sed -i 's/\(-l db_cxx\)/-l boost_chrono$(BOOST_LIB_SUFFIX) \1/' \
			src/makefile.unix
	fi
}

src_configure() {
	OPTS=(
		"DEBUGFLAGS="
		"CXXFLAGS=${CXXFLAGS}"
		"LDFLAGS=${LDFLAGS}"
		"USE_SYSTEM_LEVELDB=1"
		"BDB_INCLUDE_PATH=$(db_includedir "${DB_VER}")"
		"BDB_LIB_SUFFIX=-${DB_VER}"
	)

	if use upnp; then
		OPTS+=("USE_UPNP=1")
	else
		OPTS+=("USE_UPNP=-")
	fi

	use ipv6 || OPTS+=("USE_IPV6=-")
	use cpu_flags_x86_sse2 && OPTS+=("USE_SSE2=1")

	cd src || die
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" \
		  -f makefile.unix "${OPTS[@]}" ${PN}
}

src_test() {
	cd src || die
	emake CC="$(tc-getCC)" CXX="$(tc-getCXX)" \
		  -f makefile.unix "${OPTS[@]}" test_ppcoin
	./test_ppcoin || die 'Tests failed'
}

src_install() {
	local UG="${MY_PN}"
	dobin src/${PN}

	insinto /etc/${MY_PN}
	doins "${FILESDIR}/${MY_PN}.conf"
	fowners ${UG}:${UG} /etc/${MY_PN}/${MY_PN}.conf
	fperms 600 /etc/${MY_PN}/${MY_PN}.conf

	newconfd "${FILESDIR}"/${MY_PN}.confd ${PN}
	newinitd "${FILESDIR}"/${MY_PN}.initd ${PN}
	use systemd && systemd_dounit "${FILESDIR}"/${MY_PN}.service

	keepdir /var/lib/${MY_PN}/.${MY_PN}

	newman contrib/debian/manpages/bitcoind.1 ${PN}.1
	newman contrib/debian/manpages/bitcoin.conf.5 ${MY_PN}.conf.5

	if use examples; then
		docinto examples
		dodoc -r contrib/{bitrpc,pyminer,wallettools}

	fi

	if use logrotate; then
		insinto /etc/logrotate.d
		newins "${FILESDIR}"/${PN}.logrotate ${PN}
	fi
}
