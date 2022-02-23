# Copyright 2017-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
COIN_SYMBOL="OK"
MY_PV=${PV}-core.bliss

inherit altcoin

HOMEPAGE="http://okcash.co"
SRC_URI="https://github.com/okcashpro/${COIN_NAME}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

src_prepare() {
	local PVM=4.0
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	altcoin_src_prepare
}
