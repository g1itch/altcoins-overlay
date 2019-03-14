# Copyright 2016-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6
inherit autotools flag-o-matic

MY_PN=${PN}-yespower
DESCRIPTION="Optimized multi algo CPU miner"
HOMEPAGE="https://github.com/bubasik/${MY_PN}"
SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE="cpu_flags_x86_sse2 cpu_flags_x86_sse4_2 cpu_flags_x86_aes cpu_flags_x86_avx2 curl"
REQUIRED_USE="cpu_flags_x86_sse2"

DEPEND="curl? ( >=net-misc/curl-7.15[ssl] )"
RDEPEND="${DEPEND}
	dev-libs/gmp:0
	dev-libs/jansson
	dev-libs/openssl:0
	!net-misc/cpuminer-multi"

S="${WORKDIR}"/${MY_PN}-${PV}

src_prepare() {
	default
	replace-flags -O2 -O3
	append-cflags -msse2
	use cpu_flags_x86_aes && use cpu_flags_x86_sse4_2 \
		&& append-cflags -march=westmere
	use cpu_flags_x86_avx2 && append-cflags -march=core-avx2
	sed -ie "s#\[${PN}\], \[3.8.8.1\]#\[${PN}\], \[${PV}\]#g" configure.ac
	eautoreconf
}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	econf --with-crypto $(use_with curl)
}

src_install() {
	default
	newinitd "${FILESDIR}"/cpuminer.initd cpuminer
}
