# Copyright 2016-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="BAY"

inherit altcoin

HOMEPAGE="http://bitbay.market/"
COMMIT="09510c5c979c2c30f943502430c12a35de07bf62"
SRC_URI="https://github.com/dzimbeck/${COIN_NAME}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+wallet examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/BitBay-${COMMIT}

src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	altcoin_src_prepare
}
