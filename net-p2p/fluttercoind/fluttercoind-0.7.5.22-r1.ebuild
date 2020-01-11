# Copyright 2016-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="FLT"
MY_PV=${PV}-flt

inherit versionator altcoin

HOMEPAGE="https://fluttercoin.me/"
SRC_URI="https://github.com/ofeefee/${COIN_NAME}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"


src_prepare() {
	local PVM=$(get_version_component_range 1-3)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb_no_zerocoin.patch
	epatch "${FILESDIR}"/${PVM}-miniupnpc_1.9.patch
	epatch "${FILESDIR}"/${PVM}-boost_1.70.patch
	epatch "${FILESDIR}"/${PVM}-openssl_1.1.patch
	epatch "${FILESDIR}"/${PVM}-smessage.patch
	epatch "${FILESDIR}"/${PVM}-no_zerocoin.patch
	altcoin_src_prepare
}

src_install() {
	altcoin_src_install
	ewarn 'This coin is probably dead since 2018!'
	ewarn 'Use with caution!'
	ewarn 'Look at https://bitcointalk.org/index.php?topic=752630.1500'
}
