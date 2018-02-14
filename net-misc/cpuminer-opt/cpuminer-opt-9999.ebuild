# Copyright 2016-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools flag-o-matic git-r3


DESCRIPTION="Optimized multi algo CPU miner"
HOMEPAGE="https://github.com/JayDDee/${PN}"
EGIT_REPO_URI="${HOMEPAGE}"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
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
	replace-flags -march=x86-64 -march=native
	use cpu_flags_x86_avx2 && append-cflags -DFOUR_WAY
	eautoreconf
}

src_install() {
	default
	newinitd "${FILESDIR}"/cpuminer.initd cpuminer
}
