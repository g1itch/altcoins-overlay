# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="SLG"
MY_PV=${PV/_*/}

inherit versionator altcoin

COMMIT="17e3f5451b9d93e8e62521f387bf9e194ef6abaa"
HOMEPAGE="http://sterlingcoin.org.uk/"
SRC_URI="https://github.com/${COIN_NAME}/${COIN_NAME}-${MY_PV}-Release/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${COIN_NAME^}-${MY_PV}-Release-${COMMIT}

src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	epatch "${FILESDIR}"/${PVM}-miniupnpc_1.9.patch
	altcoin_src_prepare
}
