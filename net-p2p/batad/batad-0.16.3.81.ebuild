# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="BTA"
COIN_FAMILY="DASH"
MyPN="Bataoshi"

inherit altcoin versionator

MY_PV=${PV}-LINUX
HOMEPAGE="http://www.bata.io/"
SRC_URI="https://github.com/${COIN_SYMBOL}-${COIN_NAME}/${MyPN}/archive/v${MY_PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples upnp +wallet zeromq"

# >=dev-libs/univalue-1.0.4
RDEPEND+=">=dev-libs/leveldb-1.18-r1
	zeromq? ( net-libs/zeromq )"

S="${WORKDIR}"/${MyPN}-${MY_PV}


src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	rm -r src/leveldb
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	altcoin_src_prepare
}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	local my_econf=
	has test $FEATURES || my_econf="${my_econf} --disable-tests --disable-bench"
	econf \
		$(use_with upnp miniupnpc) \
		$(use_enable upnp upnp-default) \
		$(use_enable wallet) \
		$(use_enable zeromq zmq) \
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
	mv src/bitcoind src/${PN}
	altcoin_src_install
}
