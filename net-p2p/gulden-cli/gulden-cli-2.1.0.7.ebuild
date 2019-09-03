# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_BOOST_MIN="1.66"

inherit altcoin

MyPN="gulden-official"
DESCRIPTION="Command-line JSON-RPC client for ${COIN_NAME^} crypto-currency"
HOMEPAGE="https://gulden.com/"
SRC_URI="https://github.com/Gulden/${MyPN}/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~amd64"
IUSE=""

S="${WORKDIR}"/${MyPN}-${PV}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	econf --disable-tests --disable-bench \
		  --without-daemon \
		  --without-libs \
		  --without-gui \
		  --with-utils
}

src_install() {
	newbin src/${PN^} ${PN}

	newman doc/man/${PN^}.1 ${PN}.1
	newbashcomp contrib/${PN^}.bash-completion ${PN}
}
