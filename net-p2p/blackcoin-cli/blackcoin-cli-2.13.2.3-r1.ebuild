# Copyright 2018-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="BLK"
DB_VER=6.2

inherit altcoin

MyPN=${COIN_NAME}-more
HOMEPAGE="http://www.blackcoin.org/"
SRC_URI="https://gitlab.com/${COIN_NAME}/${MyPN}/-/archive/v${PV}/${MyPN}-v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}"/${MyPN}-v${PV}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	econf --disable-tests --disable-bench \
		  --without-daemon \
		  --without-libs \
		  --without-gui \
		  --with-utils
}

src_install() {
	newbin src/blackmore-cli ${PN}

	newman contrib/debian/manpages/bitcoin-cli.1 ${PN}.1
	newbashcomp contrib/bitcoind.bash-completion ${PN}
}
