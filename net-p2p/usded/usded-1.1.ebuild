# Copyright 2015-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="USDE"
MY_PN="USDEd"
MY_PV="1.0.0"

inherit altcoin

HOMEPAGE="http://usde.co/"
MyPN="${COIN_NAME}-master"
SRC_URI="https://github.com/owner232/${MyPN}/archive/v${MY_PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="cpu_flags_x86_sse2 examples ipv6 upnp"

S="${WORKDIR}/${MyPN}-${MY_PV}"


src_prepare() {
	rm .gitattributes .gitignore
	mkdir -p src/obj/zerocoin
	epatch "${FILESDIR}"/1.0-sys_leveldb.patch
	altcoin_src_prepare
}

src_install() {
	mv src/${MY_PN} src/${PN}
	altcoin_src_install
	ewarn 'This coin is dead since 2015,'
	ewarn 'since august 2017 thraded on YoBit only'
	ewarn 'and may be a SCAM zombie!'
	ewarn 'Use with caution!'
	ewarn 'Look at https://bitcointalk.org/index.php?topic=410254.10040'
	ewarn 'and https://bitcointalk.org/index.php?topic=2064798.0'
}
