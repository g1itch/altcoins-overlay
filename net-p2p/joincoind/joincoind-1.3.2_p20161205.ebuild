# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="J"

inherit versionator altcoin

HOMEPAGE="http://www.vericoin.info/"
COMMIT="cdd870f6c94a0e825b0070f868cb55e0af8cf4eb"
SRC_URI="https://github.com/pallas1/${COIN_NAME}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="cpu_flags_x86_sse2 examples ipv6 upnp"

RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}/${COIN_NAME}-${COMMIT}"

src_prepare() {
	epatch "${FILESDIR}"/$(get_version_component_range 1-2)-sys_leveldb.patch
	altcoin_src_prepare
}
