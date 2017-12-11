# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="HONEY"

inherit versionator altcoin

HOMEPAGE="http://honeycoin.info/"
SRC_URI="https://github.com/cryptofun/${COIN_NAME}/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS=""
IUSE="+wallet examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

src_prepare() {
	local PVM=1.0
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	altcoin_src_prepare
}

src_install() {
	altcoin_src_install
	ewarn 'The blockchain is broken since October 2017'
	ewarn 'and not syncs without special crafted snapshot.'
	ewarn 'Maybe this coin is SCAM.'
	ewarn 'Use with caution!'
	ewarn 'Look at https://bitcointalk.org/index.php?topic=1823432.820'
}
