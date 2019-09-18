# Copyright 2016-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="NOTE"
MyPN=DNotes2.0

inherit altcoin versionator

COMMIT="5dbf99d34ecd2a939fc5306525c3b197243259ba"
HOMEPAGE="http://dnotescoin.com/"
SRC_URI="https://github.com/${COIN_NAME}Coin/${MyPN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${MyPN}-${COMMIT}


src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	altcoin_src_prepare
}
