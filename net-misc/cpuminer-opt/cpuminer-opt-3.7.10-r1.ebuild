# Copyright 2016-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools flag-o-matic

DESCRIPTION="Optimized multi algo CPU miner"
HOMEPAGE="https://github.com/JayDDee/${PN}"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cpu_flags_x86_sse2 cpu_flags_x86_avx2 curl"
REQUIRED_USE="cpu_flags_x86_sse2"

DEPEND="curl? ( >=net-misc/curl-7.15[ssl] )"
RDEPEND="${DEPEND}
	dev-libs/gmp:0
	dev-libs/jansson
	dev-libs/openssl:0
	!net-misc/cpuminer-multi"

src_prepare() {
	default
	replace-flags -O2 -O3
	append-cflags -march=native
	use cpu_flags_x86_avx2 && append-cflags -DFOUR_WAY
	epatch "${FILESDIR}"/cpuminer-multi-1.1-curl-openssl.patch
	eautoreconf
}

src_install() {
	default
	newinitd "${FILESDIR}"/cpuminer.initd cpuminer
}
