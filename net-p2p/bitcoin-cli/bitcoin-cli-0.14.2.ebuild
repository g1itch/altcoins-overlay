# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="BTC"
COIN_NEEDS_SSL=0

inherit altcoin

HOMEPAGE="https://bitcoin.org"
SRC_URI="https://github.com//${COIN_NAME}/${COIN_NAME}/archive/v${MY_PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

RESTRICT="nomirror"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND+="dev-lang/yasm"

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	econf --with-utils \
		  --without-gui \
		  --without-libs \
		  --without-daemon \
		  --with-system-univalue \
		  --disable-ccache \
		  --disable-static \
		  --disable-tests --disable-bench
}

src_install() {
	dobin src/${PN}
}
