# Copyright 2015-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="SFR"

inherit altcoin

HOMEPAGE="http://saffroncoin.com/"
SRC_URI="https://github.com/${COIN_NAME}/${COIN_NAME}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="cpu_flags_x86_sse2 examples ipv6 upnp"

RDEPEND+="virtual/bitcoin-leveldb"

src_prepare() {
	epatch "${FILESDIR}"/${P}-sys_leveldb.patch
	altcoin_src_prepare
}
