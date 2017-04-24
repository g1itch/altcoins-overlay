# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="ORB"
MY_PV=${PV}.0.0-orb

inherit versionator altcoin

HOMEPAGE="http://orbitcoin.org/"
SRC_URI="https://github.com/${COIN_NAME}/${COIN_NAME}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${COIN_NAME^}-${MY_PV}


src_prepare() {
	epatch "${FILESDIR}"/$(get_version_component_range 1-2)-sys_leveldb.patch
	altcoin_src_prepare
}
