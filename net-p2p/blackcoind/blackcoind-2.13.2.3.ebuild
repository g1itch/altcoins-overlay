# Copyright 2015-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="BLK"
COIN_NEEDS_SSL=0

inherit altcoin

MyPN=${COIN_NAME}-more
HOMEPAGE="http://www.blackcoin.org/"
SRC_URI="https://gitlab.com/${COIN_NAME}/${MyPN}/-/archive/v${PV}/${MyPN}-v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+wallet examples upnp zeromq"

RDEPEND+="
	>=dev-libs/leveldb-1.18-r1
	dev-libs/univalue
	zeromq? ( net-libs/zeromq )
"

S="${WORKDIR}"/${MyPN}-v${PV}

src_prepare() {
	rm -r src/leveldb
	epatch "${FILESDIR}"/2.12-sys_leveldb.patch
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
	mv src/blackmored src/${PN}
	altcoin_src_install
}
