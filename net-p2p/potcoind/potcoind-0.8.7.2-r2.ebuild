# Copyright 2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

inherit altcoin

MY_PN="potcoin"
COMMIT="5c2b9dac24344c96c18a049d8a7b116946de7edd"
DESCRIPTION="Potcoin crypto-currency p2p network daemon"
HOMEPAGE="http://www.potcoin.com/"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/${COMMIT}.zip -> ${P}.zip"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="cpu_flags_x86_sse2 examples ipv6 upnp"

RDEPEND+="virtual/bitcoin-leveldb"
S="${WORKDIR}/${MY_PN^}-${COMMIT}"


src_prepare() {
	epatch "${FILESDIR}"/${P}-sys_leveldb.patch
	altcoin_src_prepare
}
