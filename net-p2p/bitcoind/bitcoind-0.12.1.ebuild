# Copyright 2015-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="BTC"
MY_PV=${PV}-addrindex

inherit versionator altcoin

HOMEPAGE="https://bitcoin.org"
SRC_URI="https://github.com/btcdrak/${COIN_NAME}/archive/v${MY_PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples upnp +wallet zeromq"

RDEPEND+="
	>=dev-libs/leveldb-1.18-r1
	>=dev-libs/libsecp256k1-0.0.0_pre20151118[recovery]
	dev-libs/univalue
	zeromq? ( net-libs/zeromq )
"
DEPEND+="dev-lang/yasm"


src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	eautoreconf
	rm -r src/leveldb
}

src_configure() {
	local my_econf=
	has test $FEATURES || \
		my_econf="${my_econf} --disable-tests --disable-bench"
	econf --with-gui=no \
		  --without-libs \
		  --without-utils \
		  --with-system-leveldb \
		  --with-system-libsecp256k1 \
		  --with-system-univalue \
		  $(use_enable wallet) \
		  $(use_enable zeromq zmq) \
		  $(use_with upnp miniupnpc) \
		  ${my_econf}
}
