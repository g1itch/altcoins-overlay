# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="HONEY"

inherit versionator altcoin

HOMEPAGE="http://honeycoin.info/"
SRC_URI="https://github.com/cryptofun/${COIN_NAME}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+wallet examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	epatch "${FILESDIR}"/${PVM}-std.patch
	epatch "${FILESDIR}"/${PVM}-no_seed.patch
	altcoin_src_prepare
}
