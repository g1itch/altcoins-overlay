# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="BTCD"
MY_PN=BitcoinDarkd

inherit altcoin

HOMEPAGE="http://bitcoindark.com/"
COMMIT="6278bb569039e174c9848034b57e9febf7ed8bb6"
SRC_URI="https://github.com/laowais/${COIN_NAME}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${COIN_NAME}-${COMMIT}


src_prepare() {
	epatch "${FILESDIR}"/1.0-sys_leveldb.patch
	altcoin_src_prepare
	mkdir -p src/obj/zerocoin
}

src_install() {
	mv src/${MY_PN} src/${PN}
	altcoin_src_install
}
