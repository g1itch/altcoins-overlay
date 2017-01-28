# Copyright 2015-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="SLR"

inherit versionator altcoin

HOMEPAGE="http://solarcoin.org"
SRC_URI="https://github.com/onsightit/${COIN_NAME}/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

RDEPEND+="virtual/bitcoin-leveldb"


src_prepare() {
	epatch "${FILESDIR}"/$(get_version_component_range 1-2)-sys_leveldb.patch
	altcoin_src_prepare
}
