# Copyright 2017-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="RAIN"

inherit versionator altcoin

HOMEPAGE="http://condensate.co/"
COMMIT="a6bc6c7c4bb33e2b23b79a453c99fc34bbb67999"
SRC_URI="https://github.com/OBAViJEST/${COIN_NAME}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}/${COIN_NAME}-${COMMIT}"

src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	altcoin_src_prepare
}

src_install() {
	altcoin_src_install
	ewarn 'This coin is probably dead since the end of 2018!'
	ewarn 'Use with caution!'
	ewarn 'Look at https://bitcointalk.org/index.php?topic=1895018.2380'
}
