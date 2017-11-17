# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="CHESS"

inherit versionator altcoin

HOMEPAGE="http://chesscoinpro.com/"
COMMIT="d11900f25376b9c3a03b461ebf13444b0dd50d21"
SRC_URI="https://github.com/COINFORCHESS/${COIN_NAME}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/ChessCoin-${COMMIT}

src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	epatch "${FILESDIR}"/${PVM}-no_walletbuilders.patch
	epatch "${FILESDIR}"/${PVM}-miniupnpc_1.9.patch
	altcoin_src_prepare
}

src_install() {
	altcoin_src_install
	ewarn 'This coin is probably dead since april 2017!'
	ewarn 'Use with caution!'
	ewarn "Look at https://bitcointalk.org/index.php?topic=1510517.1580"
}
