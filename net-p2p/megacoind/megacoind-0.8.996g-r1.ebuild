# Copyright 2015-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="MEC"

inherit altcoin

HOMEPAGE="http://www.megacoin.co.nz"
SRC_URI="mirror://sourceforge/${COIN_NAME}/files/${COIN_NAME}-${PV/g/G}-source.zip"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="cpu_flags_x86_sse2 examples ipv6 upnp"

RDEPEND+="virtual/bitcoin-leveldb"
S="${WORKDIR}"


src_prepare() {
	epatch "${FILESDIR}"/${P}-sys_leveldb.patch
	epatch "${FILESDIR}"/${P}-boost-replace_all.patch
	altcoin_src_prepare
}
