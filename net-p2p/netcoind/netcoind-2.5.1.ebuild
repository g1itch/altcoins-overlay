# Copyright 2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="NET"

inherit altcoin

HOMEPAGE="http://netcoin.io/"
SRC_URI="https://github.com/${COIN_NAME}foundation/${COIN_NAME}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp cpu_flags_x86_sse2" # ! no sse2


src_prepare() {
	epatch "${FILESDIR}"/2.4-sys_leveldb.patch
	altcoin_src_prepare
}
