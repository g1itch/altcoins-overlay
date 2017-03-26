# Copyright 2015-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

inherit altcoin

DESCRIPTION="Command-line JSON-RPC client for Digibyte crypto-currency"
COMMIT="077cec16d82e371ccf6ffda38f59ddd07b421d2e"
HOMEPAGE="http://digibyte.co/"
SRC_URI="https://github.com/${COIN_NAME}/${COIN_NAME}/archive/${COMMIT}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}/${COIN_NAME}-${COMMIT}"

src_configure() {
	econf \
		--disable-ccache \
		--disable-tests \
		--without-daemon \
		--without-libs \
		--with-utils
}

src_install() {
	dobin src/${PN}

	doman doc/man/${PN}.1
	newbashcomp contrib/${PN}.bash-completion ${PN}
}
