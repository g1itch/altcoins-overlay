# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

COIN_SYMBOL="LTC"

inherit altcoin

HOMEPAGE="https://litecoin.org/"
SRC_URI="https://github.com/${COIN_NAME}-project/${COIN_NAME}/archive/v${PV}.tar.gz -> ${COIN_NAME}.tar.gz"

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples upnp +wallet"

RDEPEND+="
	>=dev-libs/leveldb-1.18-r1
"

src_prepare() {
	rm -r src/leveldb
	epatch "${FILESDIR}"/${PV}-sys_leveldb.patch
	eautoreconf
}

src_configure() {
	# To avoid executable GNU stack.
	append-ldflags -Wl,-z,noexecstack

	local my_econf=
	if use upnp; then
		my_econf="${my_econf} --with-miniupnpc --enable-upnp-default"
	else
		my_econf="${my_econf} --without-miniupnpc --disable-upnp-default"
	fi
	econf \
		$(use_enable wallet)\
		--disable-ccache \
		--disable-static \
		--disable-tests \
		--with-system-leveldb \
		--with-system-libsecp256k1  \
		--without-libs \
		--with-daemon  \
		--without-gui     \
		--without-qrencode \
		${my_econf}
}
