# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="BRO"
MY_PN=${PN^}

inherit versionator altcoin

HOMEPAGE="http://bitrad.io/"
COMMIT="e82b9df5da450c5c21c8af74199c4121ada98e99"
SRC_URI="https://github.com/the${COIN_NAME}/${COIN_NAME}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="+wallet examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${COIN_NAME^}-${COMMIT}


src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	altcoin_src_prepare
}

src_install() {
	mv src/${MY_PN} src/${PN}
	altcoin_src_install
}
