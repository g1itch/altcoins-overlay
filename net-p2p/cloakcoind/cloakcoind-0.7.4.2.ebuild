# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="CLOAK"

inherit versionator altcoin

HOMEPAGE="https://www.cloakcoin.com/en/"
COMMIT="9f318b895ebd7babc9324475d539d79c33764bc4"
SRC_URI="https://github.com/cashmen/${COIN_NAME}Relaunch/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/CloakCoinRelaunch-${COMMIT}

# src_prepare() {
# 	local PVM=$(get_version_component_range 1-2)
# 	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
# 	altcoin_src_prepare
# }
