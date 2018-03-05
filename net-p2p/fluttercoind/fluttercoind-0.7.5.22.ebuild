# Copyright 2016-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="FLT"
MY_PV=${PV}-flt

inherit versionator altcoin

HOMEPAGE="https://bitcointalk.org/index.php?topic=509499.0"
SRC_URI="https://github.com/ofeefee/${COIN_NAME}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"


src_prepare() {
	mv src/makefile.linux src/makefile.unix
	local PVM=$(get_version_component_range 1-3)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	epatch "${FILESDIR}"/${PVM}-miniupnpc_1.9.patch
	altcoin_src_prepare
}
