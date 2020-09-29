# Copyright 2017-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="CHESS"

inherit versionator altcoin

HOMEPAGE="https://chess-coin.github.io/"
SRC_URI="https://github.com/AKKPP/${COIN_NAME}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/ChessCoin-${PV}

src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb_no_zerocoin.patch
	epatch "${FILESDIR}"/${PVM}-openssl_1.1.patch
	epatch "${FILESDIR}"/${PVM}-boost_1.70.patch
	epatch "${FILESDIR}"/${PVM}-no_zerocoin.patch
	mkdir -p src/obj
	altcoin_src_prepare
}

src_install() {
	altcoin_src_install
	ewarn 'This coin is probably dead since april 2017!'
	ewarn 'Use with caution!'
	ewarn "Look at https://bitcointalk.org/index.php?topic=1510517.1580"
}
