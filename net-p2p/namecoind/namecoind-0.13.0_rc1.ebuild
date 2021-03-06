# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
COIN_SYMBOL="NMC"

inherit versionator altcoin

MY_PN=${COIN_NAME}-core
MY_PV=nc${PV/_/}
HOMEPAGE="http://namecoin.info/"
SRC_URI="https://github.com/${COIN_NAME}/${MY_PN}/archive/${MY_PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples upnp +wallet zmq"

# asm?
RDEPEND+="
	>=dev-libs/leveldb-1.18-r1
	dev-libs/univalue
	zmq? ( net-libs/zeromq )
"

S="${WORKDIR}"/${MY_PN}-${MY_PV}

src_prepare() {
	rm -r src/leveldb
	epatch "${FILESDIR}"/$(get_version_component_range 1-2)-sys_leveldb.patch
	eautoreconf
}

src_configure() {
	# To avoid executable GNU stack.
	append-ldflags -Wl,-z,noexecstack

	local my_econf=
	has test $FEATURES || my_econf="${my_econf} --disable-tests"
	econf \
		$(use_with upnp miniupnpc) \
		$(use_enable upnp upnp-default) \
		$(use_enable wallet) \
		$(use_enable zmq) \
		--disable-ccache \
		--disable-static \
		--with-system-leveldb \
		--with-system-univalue \
		--with-system-libsecp256k1 \
		--without-utils \
		--without-libs \
		--without-gui \
		--with-daemon \
		${my_econf}
}
