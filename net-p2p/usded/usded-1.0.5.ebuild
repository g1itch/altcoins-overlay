# Copyright 2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

inherit altcoin

MY_PN="usde"
DESCRIPTION="USDe crypto-currency p2p network daemon"
HOMEPAGE="http://www.usd-e.com/"
SRC_URI="https://github.com/testzcrypto/${MY_PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="cpu_flags_x86_sse2 examples ipv6 upnp"

# RDEPEND+="virtual/bitcoin-leveldb"
S="${WORKDIR}/${MY_PN^^}-${PV}"

# src_prepare() {
# 	epatch "${FILESDIR}"/${P}-sys_leveldb.patch
# 	altcoin_src_prepare
# }
