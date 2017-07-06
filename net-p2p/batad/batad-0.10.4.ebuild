# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="BTA"
# COIN_FAMILY="DASH" ?
MY_PN="BATAd"
MyPN="BATA-SOURCE"
MY_PV=${PV}-rc1_Linux64

inherit versionator altcoin

HOMEPAGE="http://www.bata.io/"
SRC_URI="https://github.com/${COIN_SYMBOL}-${COIN_NAME}/${MyPN}/archive/v${MY_PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples upnp +wallet libressl"

RDEPEND+=">=dev-libs/leveldb-1.18-r1"

S="${WORKDIR}"/${MyPN}-${MY_PV}


src_prepare() {
	rm -r src/leveldb
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	altcoin_src_prepare
}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	local my_econf=
	has test $FEATURES || my_econf="${my_econf} --disable-tests"
	econf --without-gui \
		  --without-libs \
		  --without-utils \
		  --with-system-leveldb \
		  $(use_enable wallet) \
		  $(use_enable upnp upnp-default) \
		  $(use_with libressl) \
		  $(use_with upnp miniupnpc) \
		  ${my_econf}
}

src_install() {
	mv src/${MY_PN} src/${PN}
	altcoin_src_install
}
