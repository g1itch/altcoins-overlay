# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="GRC"

inherit versionator altcoin

MyPN=${COIN_NAME^}-Research
HOMEPAGE="https://gridcoin.us/"
SRC_URI="https://github.com/${COIN_NAME}-community/${MyPN}/archive/${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples upnp +wallet"

RDEPEND+="
	>=dev-libs/leveldb-1.18-r1
	>=dev-libs/univalue-1.0.4
"

S="${WORKDIR}"/${MyPN}-${PV}

src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	rm -r src/leveldb
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	eautoreconf
}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	local my_econf=
	has test $FEATURES || my_econf="${my_econf} --disable-tests --disable-bench"
	econf \
		$(use_with upnp miniupnpc) \
		$(use_enable upnp upnp-default) \
		$(use_enable wallet) \
		--disable-ccache \
		--disable-static \
		--with-system-leveldb \
		--without-utils \
		--without-libs \
		--without-gui \
		--with-daemon \
		${my_econf}
}

src_install() {
	mv src/gridcoinresearchd src/${PN}
	altcoin_src_install
	insinto /etc/coins/
	doins ${FILESDIR}/${COIN_NAME}.conf
}
