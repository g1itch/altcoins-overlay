# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="UNIT"
MY_PN="UniversalCurrencyd"

inherit versionator altcoin

HOMEPAGE="https://bitcointalk.org/index.php?topic=1037825.0"
COMMIT="de2dfec3aded298fe752558e39a477d45d96dce8"
SRC_URI="https://github.com/${COIN_NAME}currency/${COIN_NAME}currency/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${COIN_NAME}currency-${COMMIT}

src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	altcoin_src_prepare
}

src_install() {
	mv src/${MY_PN} src/${PN}
	altcoin_src_install
	ewarn 'This coin is probably dead since april 2017!'
	ewarn 'Use with caution!'
	ewarn "Look at ${HOMEPAGE}"
}
