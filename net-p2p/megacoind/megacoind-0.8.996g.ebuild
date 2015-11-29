# Copyright 2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

inherit altcoin

MY_PN="megacoin"
DESCRIPTION="Megacoin crypto-currency p2p network daemon"
HOMEPAGE="http://www.megacoin.co.nz"
SRC_URI="mirror://sourceforge/${MY_PN}/files/${MY_PN}-${PV/g/G}-source.zip"

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
