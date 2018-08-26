# Copyright 2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="BRK"

inherit versionator altcoin

MyPN=${COIN_NAME^}-Chain-Client
HOMEPAGE="http://www.breakoutcoin.com/"
SRC_URI="https://github.com/${COIN_NAME}Coin/${MyPN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+wallet examples ipv6 -upnp"  # some bug in net.cpp

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${MyPN}-${PV}


src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_libs.patch
	epatch "${FILESDIR}"/${PVM}-miniupnpc_1.9.patch
	altcoin_src_prepare
}
