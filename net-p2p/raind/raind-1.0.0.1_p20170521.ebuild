# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="RAIN"

inherit versionator altcoin

HOMEPAGE="http://condensate.co/"
COMMIT="9ef82835a7839e0629e65c2b4ecfee8be2206487"
SRC_URI="https://github.com/OBAViJEST/${COIN_NAME}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${COIN_NAME}-${COMMIT}

src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	epatch "${FILESDIR}"/${PVM}-miniupnpc_1.9.patch
	altcoin_src_prepare
}
