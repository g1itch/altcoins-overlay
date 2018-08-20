# Copyright 2015-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit altcoin

DESCRIPTION="Command-line JSON-RPC client for Digibyte crypto-currency"
HOMEPAGE="http://digibyte.co/"
SRC_URI="https://github.com/${COIN_NAME}/${COIN_NAME}/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""


src_configure() {
	append-ldflags -Wl,-z,noexecstack
	econf --disable-tests --disable-bench \
		--disable-ccache \
		--without-daemon \
		--without-libs \
		--without-gui \
		--with-utils
}

src_install() {
	dobin src/${PN}

	doman doc/man/${PN}.1
	newbashcomp contrib/${PN}.bash-completion ${PN}
}
