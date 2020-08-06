# Copyright 2017-2020 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="SLG"

inherit versionator altcoin

PVM=$(get_version_component_range 1-2)
HOMEPAGE="http://sterlingcoin.org.uk/"
SRC_URI="https://github.com/${COIN_NAME}/${COIN_NAME}-${PVM}-Release/archive/${COIN_NAME^}-${PV}-Release.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${COIN_NAME^}-${PVM}-Release-${COIN_NAME^}-${PV}-Release

src_prepare() {
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	altcoin_src_prepare
}
