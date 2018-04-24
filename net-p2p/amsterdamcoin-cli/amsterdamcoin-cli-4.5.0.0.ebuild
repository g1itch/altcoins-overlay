# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="AMS"

inherit altcoin

MyPN=AmsterdamCoin-v4
HOMEPAGE="https://amsterdamcoin.com/"
SRC_URI="https://github.com/CoinProjects/${COIN_NAME}-v4/archive/v${MY_PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"

S="${WORKDIR}"/${MyPN}-${PV}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	has test $FEATURES || my_econf="${my_econf} --disable-tests"
	econf \
		--disable-ccache \
		--disable-static \
		--with-system-leveldb \
		--with-utils \
		--without-libs \
		--without-gui \
		--without-daemon
}

src_install() {
	dobin src/${PN}
}
