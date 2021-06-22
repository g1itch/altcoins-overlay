# Copyright 2017-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
COIN_SYMBOL="J"

inherit versionator altcoin

HOMEPAGE="http://joincoinz.com/"
COMMIT="cdd870f6c94a0e825b0070f868cb55e0af8cf4eb"
SRC_URI="https://github.com/pallas1/${COIN_NAME}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}/${COIN_NAME}-${COMMIT}"

src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	epatch "${FILESDIR}"/${PVM}-miniupnpc_1.9.patch
	altcoin_src_prepare
}
