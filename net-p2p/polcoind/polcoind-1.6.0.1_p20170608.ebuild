# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="PLC"

inherit versionator altcoin

MyPN="${COIN_NAME}-new"
COMMIT="45af7c918cdf7f281dd032dd431a78223406a912"
HOMEPAGE="https://polcoin.pl/"
SRC_URI="https://github.com/pdrobek/${MyPN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples upnp ipv6"

RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${MyPN}-${COMMIT}

src_prepare() {
        local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
        epatch "${FILESDIR}"/${PVM}-miniupnpc_1.9.patch
	altcoin_src_prepare
}
