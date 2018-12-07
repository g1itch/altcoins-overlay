# Copyright 2017-2018 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="ORB"
MY_PV=${PV}-orb

inherit versionator altcoin

HOMEPAGE="http://orbitcoin.org/"
SRC_URI="https://github.com/ghostlander/${COIN_NAME}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${COIN_NAME^}-${MY_PV}


src_prepare() {
	epatch "${FILESDIR}"/$(get_version_component_range 1-3)-sys_leveldb.patch
	altcoin_src_prepare
}
