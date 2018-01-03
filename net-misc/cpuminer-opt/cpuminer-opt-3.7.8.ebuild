# Copyright 2016-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
inherit eutils autotools flag-o-matic

DESCRIPTION="Optimized multi algo CPU miner"
HOMEPAGE="https://github.com/JayDDee/${PN}"
SRC_URI="${HOMEPAGE}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cpu_flags_x86_avx2"

DEPEND="net-misc/curl"
RDEPEND="${DEPEND}
	dev-libs/jansson
	dev-libs/openssl
	!net-misc/cpuminer-multi"

src_prepare() {
	replace-flags -O2 -O3
	append-cflags -march=native
	append-cxxflags -std=c++11
	use cpu_flags_x86_avx2 && append-cflags -DFOUR_WAY
	epatch "${FILESDIR}"/cpuminer-multi-1.1-curl-openssl.patch
	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install
	newinitd "${FILESDIR}"/cpuminer.initd cpuminer
}
