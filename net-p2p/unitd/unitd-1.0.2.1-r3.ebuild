# Copyright 2017-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="UNIT"
MY_PN="UniversalCurrencyd"

inherit versionator altcoin

HOMEPAGE="https://bitcointalk.org/index.php?topic=1037825.0"
SRC_URI="https://github.com/${COIN_NAME}currency/${COIN_NAME}currency/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS=""
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${COIN_NAME}currency-${PV}

src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	epatch "${FILESDIR}"/${PV}-miniupnpc_1.9.patch
	altcoin_src_prepare
}

src_install() {
	mv src/${MY_PN} src/${PN}
	altcoin_src_install
	ewarn 'This coin is probably dead since 2019!'
	ewarn 'Use with caution!'
	ewarn "Look at ${HOMEPAGE}"
}
