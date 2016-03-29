# Copyright 2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

inherit altcoin

MY_PN="solarcoin"
COMMIT="916a0181e4ef52faf60c9495ae390d7d7d8d3fd4"
DESCRIPTION="Solarcoin crypto-currency p2p network daemon"
HOMEPAGE="http://solarcoin.org"
SRC_URI="https://github.com/onsightit/${MY_PN}/archive/${COMMIT}.zip -> ${P}.zip"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="cpu_flags_x86_sse2 examples ipv6 upnp"

RDEPEND+="virtual/bitcoin-leveldb"
S="${WORKDIR}/${MY_PN}-${COMMIT}"


src_prepare() {
	epatch "${FILESDIR}"/${PN}-2.0.8-sys_leveldb.patch
	altcoin_src_prepare
}

src_install() {
	altcoin_src_install
	local manpath=contrib/debian/manpages
	newman ${manpath}/novacoind.1 ${PN}.1
	newman ${manpath}/novacoin.conf.5 ${MY_PN}.conf.5
}
