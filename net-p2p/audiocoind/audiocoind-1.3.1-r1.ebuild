# Copyright 2017-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="ADC"

inherit versionator altcoin

HOMEPAGE="http://www.audiocoin.eu/"
SRC_URI="https://github.com/aurovine/${COIN_NAME}/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/AudioCoin-${PV}


src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/1.2-sys_leveldb.patch
	epatch "${FILESDIR}"/${PVM}-openssl_1.1.patch
	epatch "${FILESDIR}"/${PVM}-boost_1.70.patch
	altcoin_src_prepare
}
