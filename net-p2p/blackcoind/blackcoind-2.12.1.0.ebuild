# Copyright 2015-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="BLK"
COIN_NEEDS_SSL=0
DB_VER=6.2

inherit altcoin

MY_PV=${PV}-3d52c88
HOMEPAGE="http://www.blackcoin.co/"
SRC_URI="https://github.com/janko33bd/bitcoin/archive/v${MY_PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+wallet examples upnp zeromq"

RDEPEND+="
	>=dev-libs/leveldb-1.18-r1
	dev-libs/univalue
	zeromq? ( net-libs/zeromq )
"

S="${WORKDIR}"/bitcoin-${MY_PV}


src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	rm -r src/leveldb
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	eautoreconf
}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	local my_econf=
	has test $FEATURES || \
		my_econf="${my_econf} --disable-tests --disable-bench"
	econf --without-gui \
		  --without-libs \
		  --without-utils \
		  --with-system-leveldb \
		  --with-system-univalue \
		  $(use_enable wallet) \
		  $(use_enable zeromq zmq) \
		  $(use_enable upnp upnp-default) \
		  $(use_with upnp miniupnpc) \
		  ${my_econf}
}

src_install() {
	mv src/lored src/${PN}
	altcoin_src_install
}
