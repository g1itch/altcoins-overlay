# Copyright 2015-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="SLR"

inherit versionator altcoin

HOMEPAGE="http://solarcoin.org"
MY_PV=$(get_version_component_range 1-2)
SRC_URI="https://github.com/onsightit/${COIN_NAME}/archive/${MY_PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="cpu_flags_x86_sse2 examples upnp +wallet zmq"

RDEPEND+="
	>=dev-libs/leveldb-1.18-r1
	dev-libs/univalue
	zmq? ( net-libs/zeromq )
"

S="${WORKDIR}"/${COIN_NAME}-${MY_PV}


src_prepare() {
	rm -r src/leveldb
	epatch "${FILESDIR}"/${MY_PV}-sys_leveldb.patch
	altcoin_src_prepare
}

src_configure() {
	# To avoid executable GNU stack.
	append-ldflags -Wl,-z,noexecstack

	local my_econf=
	has test $FEATURES || my_econf="${my_econf} --disable-tests --disable-bench"
	econf \
		$(use_with upnp miniupnpc) \
		$(use_enable upnp upnp-default) \
		$(use_enable wallet) \
		$(use_enable zmq) \
		$(use_enable cpu_flags_x86_sse2 sse2) \
		--disable-ccache \
		--disable-static \
		--with-system-leveldb \
		--with-system-univalue \
		--without-utils \
		--without-libs \
		--without-gui \
		--with-daemon \
		${my_econf}
}
