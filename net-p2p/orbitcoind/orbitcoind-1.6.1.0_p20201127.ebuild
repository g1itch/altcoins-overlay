# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="ORB"

inherit versionator altcoin

COMMIT="847b142e25423b10623c00d60776c747d3fe4b0e"
HOMEPAGE="http://orbitcoin.org/"
SRC_URI="https://github.com/ghostlander/${COIN_NAME}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${COIN_NAME^}-${COMMIT}


src_prepare() {
	epatch "${FILESDIR}"/$(get_version_component_range 1-3)-sys_leveldb.patch
	altcoin_src_prepare
}
