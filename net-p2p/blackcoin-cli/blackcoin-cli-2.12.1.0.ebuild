# Copyright 2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="BLK"
DB_VER=6.2

inherit altcoin

MY_PV=${PV}-3d52c88
HOMEPAGE="http://www.blackcoin.co/"
SRC_URI="https://github.com/janko33bd/bitcoin/archive/v${MY_PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}"/bitcoin-${MY_PV}


src_configure() {
	append-ldflags -Wl,-z,noexecstack
	econf --disable-tests --disable-bench \
		  --without-daemon \
		  --without-libs \
		  --without-gui \
		  --with-utils
}

src_install() {
	newbin src/lore-cli ${PN}

	newman contrib/debian/manpages/bitcoin-cli.1 ${PN}.1
	newbashcomp contrib/bitcoind.bash-completion ${PN}
}
