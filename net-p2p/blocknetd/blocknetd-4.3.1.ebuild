# Copyright 2017-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="BLOCK"

inherit altcoin versionator

HOMEPAGE="http://blocknet.co/"
SRC_URI="https://github.com/${COIN_NAME}DX/${COIN_NAME}/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples upnp +wallet zeromq libressl"

RDEPEND+="
	>=dev-libs/leveldb-1.18-r1
	zeromq? ( net-libs/zeromq )
"

S="${WORKDIR}"/${COIN_NAME}-${PV}


src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	rm -r src/leveldb
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	epatch "${FILESDIR}"/${PVM}-missing-include.patch
	eautoreconf
}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	append-ldflags -lunivalue
	local my_econf=
	has test $FEATURES || \
		my_econf="${my_econf} --disable-tests --disable-bench"
	econf \
		$(use_with upnp miniupnpc) \
		$(use_enable upnp upnp-default) \
		$(use_enable wallet) \
		$(use_enable zeromq zmq) \
		$(use_enable libressl) \
		--disable-ccache \
		--disable-static \
		--with-system-leveldb \
		--with-system-libsecp256k1  \
		--without-utils \
		--without-libs \
		--without-gui \
		--with-daemon \
		${my_econf}
}

src_install() {
	mv src/${PN}xd src/${PN}
	altcoin_src_install
}
