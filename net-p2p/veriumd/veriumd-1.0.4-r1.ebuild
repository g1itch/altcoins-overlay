# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="VRM"

inherit altcoin

HOMEPAGE="http://www.vericoin.info/veriumlaunch.html"
SRC_URI="https://github.com/VeriumReserve/${COIN_NAME}/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="cpu_flags_x86_sse2 examples ipv6 upnp"

RDEPEND+="virtual/bitcoin-leveldb"


src_prepare() {
	epatch "${FILESDIR}"/${P}-sys_leveldb.patch
	altcoin_src_prepare
}
