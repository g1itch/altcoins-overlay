# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="USDX"
MY_PN="USDEXd"

inherit versionator altcoin

HOMEPAGE="http://unifiedsociety.org/"
MyPN="USDEX"
SRC_URI="https://github.com/owner232/${MyPN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="cpu_flags_x86_sse2 examples ipv6 upnp"

S="${WORKDIR}/${MyPN}-${PV}"


src_prepare() {
	local PVM=1.1
	rm .gitattributes .gitignore
	mkdir -p src/obj/zerocoin
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	epatch "${FILESDIR}"/${PVM}-miniupnpc_1.9.patch
	altcoin_src_prepare
}

src_install() {
	mv src/${MY_PN} src/${PN}
	altcoin_src_install
}
