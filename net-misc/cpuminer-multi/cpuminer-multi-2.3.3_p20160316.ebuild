# Copyright 2015-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
inherit eutils autotools flag-o-matic

MY_PV="${PV}-multi"
COMMIT="8393e03089c0abde61bd5d72aba8f926c3d6eca4"
DESCRIPTION="CPUMiner for cryptonight"
HOMEPAGE="https://github.com/wolf9466/${PN}"
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
	eautoreconf
}

src_install() {
	make DESTDIR="${D}" install
	newinitd "${FILESDIR}"/minerd.initd minerd
}
