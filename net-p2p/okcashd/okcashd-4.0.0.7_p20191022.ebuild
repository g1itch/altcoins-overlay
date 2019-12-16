# Copyright 2017-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="OK"
MY_PV=${PV}-core.utopia

inherit versionator altcoin

COMMIT="a3e39f30d55678457cb79a53f975322e032392d1"
HOMEPAGE="http://okcash.co"
SRC_URI="https://github.com/okcashpro/${COIN_NAME}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${COIN_NAME}-${COMMIT}

src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	epatch "${FILESDIR}"/${PVM}-boost_1.70.patch
	epatch "${FILESDIR}"/${PVM}-openssl_1.1.patch
	altcoin_src_prepare
}
