# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="OWO"

inherit versionator altcoin

MY_PN="OWOd"
HOMEPAGE="https://owo.world"
COMMIT="465f40a8e16b7f33b8829f3547c9cd9a5b38a0a0"
SRC_URI="https://github.com/OWOWORLD/${COIN_NAME}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${COIN_NAME^^}-${COMMIT}

src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	epatch "${FILESDIR}"/${PVM}-miniupnpc_1.9.patch
	epatch "${FILESDIR}"/${PVM}-boost_array.patch
	epatch "${FILESDIR}"/${PVM}-no_seed.patch
	altcoin_src_prepare
}

src_install() {
	mv src/${MY_PN} src/${PN}
	altcoin_src_install
	# ewarn 'This coin is probably dead since Jan 2017!'
	# ewarn 'Use with caution!'
	# ewarn 'Look at https://bitcointalk.org/index.php?topic=888944.0'
}
