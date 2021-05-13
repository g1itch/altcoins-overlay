# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="ADC"

inherit versionator altcoin

HOMEPAGE="http://www.audiocoin.eu/"
COMMIT="dac5bcf25436141cc6c1a270f6e3b27a0eb13d78"
SRC_URI="https://github.com/aurovine/${COIN_NAME}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/AudioCoin-${COMMIT}


src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/1.2-sys_leveldb.patch
	epatch "${FILESDIR}"/${PVM}-boost_1.70.patch
	altcoin_src_prepare
}
