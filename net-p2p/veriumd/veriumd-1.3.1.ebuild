# Copyright 2017-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="VRM"

inherit versionator altcoin

HOMEPAGE="http://www.vericoin.info/veriumlaunch.html"
SRC_URI="https://github.com/VeriumReserve/${COIN_NAME}/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples upnp +wallet zeromq"

DEPEND+="virtual/awk net-misc/curl"
RDEPEND+="virtual/bitcoin-leveldb"


src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	eautoreconf
}

src_configure() {
		append-ldflags -Wl,-z,noexecstack
		local my_econf=
		has test $FEATURES || \
				my_econf="${my_econf} --disable-tests --disable-bench"
		econf \
				$(use_with upnp miniupnpc) \
				$(use_enable upnp upnp-default) \
				$(use_enable wallet) \
				$(use_enable zeromq zmq) \
				--disable-ccache \
				--disable-static \
				--with-system-leveldb \
				--with-system-univalue \
				--with-system-libsecp256k1  \
				--without-utils \
				--without-libs \
				--without-gui \
				--with-daemon \
				${my_econf}
}
