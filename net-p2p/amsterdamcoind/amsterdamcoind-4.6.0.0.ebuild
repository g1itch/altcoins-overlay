# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="AMS"

inherit altcoin

MyPN=AmsterdamCoin-v4
HOMEPAGE="https://amsterdamcoin.com/"
SRC_URI="https://github.com/CoinProjects/${COIN_NAME}-v4/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples upnp +wallet zmq libressl"

RDEPEND+=">=dev-libs/leveldb-1.18-r1"
DEPEND+="zmq? ( net-libs/zeromq )"

S="${WORKDIR}"/${MyPN}-${PV}

src_prepare() {
	local PVM=$(get_major_version)
	rm -r src/leveldb
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	eautoreconf
}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	local my_econf=
	has test $FEATURES || my_econf="${my_econf} --disable-tests"
	econf \
		$(use_with libressl) \
		$(use_with upnp miniupnpc) \
		$(use_enable upnp upnp-default) \
		$(use_enable wallet) \
		$(use_enable zmq) \
		--disable-ccache \
		--disable-static \
		--with-system-leveldb \
		--without-utils \
		--without-libs \
		--without-gui \
		--with-daemon \
		${my_econf}
}
