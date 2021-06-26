# Copyright 2015-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="SLR"

inherit versionator altcoin

HOMEPAGE="http://solarcoin.org"
SRC_URI="https://github.com/onsightit/${COIN_NAME}/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS=""
IUSE="examples ipv6 upnp"

RDEPEND+="virtual/bitcoin-leveldb"


src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	epatch "${FILESDIR}"/${PVM}-miniupnpc_1.9.patch
	epatch "${FILESDIR}"/${PVM}-boost_array.patch
	altcoin_src_prepare
}

src_install() {
	altcoin_src_install
	ewarn 'This coin was migrated to the Energy Web Chain'
	ewarn 'On April 18, 2021'
	ewarn 'See https://medium.com/solarcoin/migrating-to-ethereum-based-solarcoin-the-technical-guide-ad2de4dba152'
}
