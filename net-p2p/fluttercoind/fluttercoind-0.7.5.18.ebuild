# Copyright 2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="FLT"
MY_PV=${PV}-flt

inherit altcoin

HOMEPAGE="https://bitcointalk.org/index.php?topic=509499.0"
SRC_URI="https://github.com/ofeefee/${COIN_NAME}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="cpu_flags_x86_sse2 examples ipv6 upnp"

RDEPEND+="virtual/bitcoin-leveldb"


src_prepare() {
	mv src/makefile.linux src/makefile.unix
	epatch "${FILESDIR}"/${P}-sys_leveldb.patch
	altcoin_src_prepare
}

# src_install() {
# 	altcoin_src_install
# 	ewarn 'This coin may be dead!'
# 	ewarn 'The site is down and no activity on anonce thread since
# 	ewarn 'Use with caution!'
# }
