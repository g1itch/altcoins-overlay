# Copyright 2015-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="POT"

inherit altcoin

COMMIT="5c2b9dac24344c96c18a049d8a7b116946de7edd"
HOMEPAGE="http://www.potcoin.com/"
SRC_URI="https://github.com/${COIN_NAME}/${COIN_NAME}/archive/${COMMIT}.zip -> ${P}.zip"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="cpu_flags_x86_sse2 examples ipv6 upnp"

RDEPEND+="virtual/bitcoin-leveldb"
S="${WORKDIR}/${COIN_NAME^}-${COMMIT}"


src_prepare() {
	rm CMakeLists.txt
	epatch "${FILESDIR}"/${P}-sys_leveldb.patch
	altcoin_src_prepare
}
