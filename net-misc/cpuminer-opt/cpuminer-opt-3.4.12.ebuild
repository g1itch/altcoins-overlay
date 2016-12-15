# Copyright 2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
inherit eutils autotools flag-o-matic

COMMIT="06f82c5b973b263f765a336b65be82cd3827cdb0"
DESCRIPTION="Multi-algo CPUMiner & Reference Cryptonote Miner (JSON-RPC 2.0)"
HOMEPAGE="https://github.com/JayDDee/${PN}"
SRC_URI="${HOMEPAGE}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/${PN}-${COMMIT}"

DEPEND="net-misc/curl"
RDEPEND="${DEPEND}
	dev-libs/jansson
	dev-libs/openssl
	!net-misc/cpuminer-multi"

src_prepare() {
	replace-flags -O2 -O3
	replace-flags -march=x86-64 -march=native
	append-flags -std=c++11
	epatch "${FILESDIR}"/cpuminer-multi-1.1-curl-openssl.patch
	epatch "${FILESDIR}"/cpuminer-multi-1.2-hwmon_alt4.patch
	epatch "${FILESDIR}"/${PN}-3.4.12-no-hodl.patch
	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install
	newinitd "${FILESDIR}"/cpuminer.initd cpuminer
}
