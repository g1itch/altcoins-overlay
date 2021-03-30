# Copyright 2019-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit altcoin

DESCRIPTION="Command-line JSON-RPC client for ${COIN_NAME^} crypto-currency"
HOMEPAGE="http://vergecurrency.com/"
SRC_URI="https://github.com/vergecurrency/${PN}/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""


src_prepare() {
	epatch "${FILESDIR}"/6-no_subdirs_configure.patch
	eautoreconf
}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	econf --disable-tests --disable-bench \
		--disable-ccache \
		--disable-static \
		--without-daemon \
		--without-libs \
		--without-gui \
		--with-utils
}

src_install() {
	dobin src/${PN}
}
