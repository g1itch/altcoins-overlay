# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="GHC"

inherit versionator altcoin

MyPN="GamerHolicCoin"
HOMEPAGE="https://gamerholic.com/"
COMMIT="40431a6d7d2fdedf76b358838b1fb1c0d49e5fad"
SRC_URI="https://github.com/blocktech/${MyPN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${MyPN}-${COMMIT}

src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	epatch "${FILESDIR}"/${PVM}-miniupnpc_1.9.patch
	altcoin_src_prepare
}

src_install() {
	altcoin_src_install
	ewarn 'This coin is probably dead since Jan 2017!'
	ewarn 'Use with caution!'
	ewarn 'Look at https://bitcointalk.org/index.php?topic=888944.0'
}
