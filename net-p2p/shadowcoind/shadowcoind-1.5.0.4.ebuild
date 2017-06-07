# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="SDC"

inherit versionator altcoin

MyPN="shadow"
HOMEPAGE="http://shadowproject.io/"
SRC_URI="https://github.com/${MyPN}project/${MyPN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/${MyPN}-${PV}

src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	altcoin_src_prepare
}

src_install() {
	altcoin_src_install
	ewarn 'This coin is probably dead since May 2017!'
	ewarn 'The ShadowCash team have stopped working on the Project.'
	ewarn 'Use with caution!'
	ewarn 'Look at https://shadowproject.io/'
}
