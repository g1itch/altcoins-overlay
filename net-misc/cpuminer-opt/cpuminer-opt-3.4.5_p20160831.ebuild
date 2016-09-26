# Copyright 2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
inherit eutils autotools flag-o-matic

MY_PV=${PV/_p[0-9]*/}
COMMIT="103369dfea1789914200edf1794e10593eaaad46"
DESCRIPTION="Multi-algo CPUMiner & Reference Cryptonote Miner (JSON-RPC 2.0)"
HOMEPAGE="https://github.com/felixbrucker/${PN}"
SRC_URI="${HOMEPAGE}/archive/${COMMIT}.zip -> ${P}.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}/${PN}-${COMMIT}"

DEPEND="net-misc/curl"
RDEPEND="${DEPEND}
	dev-libs/jansson
	dev-libs/openssl"

src_prepare() {
	replace-flags -O2 -O3
	replace-flags -march=x86-64 -march=native
	append-flags -std=c++11
	epatch "${FILESDIR}"/${PN}-1.1-curl-openssl.patch
	sed -e "s/\[cpuminer-multi\]/\[cpuminer-opt\]/g" \
		-e "s/, \[1.2-dev\]/, \[${MY_PV}-dev\]/g" -i configure.ac

	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install
	newinitd "${FILESDIR}"/cpuminer.initd cpuminer
}
