# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="MZC"

inherit versionator altcoin

HOMEPAGE="http://www.mazacoin.org/"
SRC_URI="https://github.com/${COIN_NAME}coin/${COIN_NAME}/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples upnp +wallet"

RDEPEND+=">=dev-libs/leveldb-1.18-r1"
DEPEND+="dev-lang/yasm"

src_prepare() {
	rm -r src/leveldb
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	epatch "${FILESDIR}"/${PVM}-miniupnpc_1.9.patch
	eautoreconf
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
		  $(use_with upnp miniupnpc) \
		  ${my_econf}
}
