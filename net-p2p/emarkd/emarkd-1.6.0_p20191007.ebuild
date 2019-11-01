# Copyright 2017-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="DEM"
MY_PN=eMarkd

inherit versionator altcoin

HOMEPAGE="http://deutsche-emark.de/"
COMMIT="dfa322ab1fb9fd5bf95f18e76f30d8d9d6d6e240"
SRC_URI="https://github.com/${COIN_NAME}project/${COIN_NAME}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${MY_PN:0:-1}-${COMMIT}

src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/1.4-sys_leveldb.patch
	epatch "${FILESDIR}"/${PVM}-boost_1.70.patch
	altcoin_src_prepare
}

src_install() {
	mv src/${MY_PN} src/${PN}
	altcoin_src_install
}
