# Copyright 2016-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="VRC"

inherit versionator altcoin

HOMEPAGE="http://www.vericoin.info/"
SRC_URI="https://github.com/${COIN_NAME}/${COIN_NAME}/archive/${PV}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="cpu_flags_x86_avx cpu_flags_x86_avx2 examples ipv6 upnp"

DEPEND+="virtual/awk net-misc/curl"
RDEPEND+="virtual/bitcoin-leveldb"


src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	altcoin_src_prepare
}

src_configure() {
	local MY_OPTS=( )
	use cpu_flags_x86_avx || MY_OPTS+=("USE_AVX=0")
	use cpu_flags_x86_avx2 && MY_OPTS+=("USE_AVX2=1")
	altcoin_src_configure "${MY_OPTS[@]}"
}
