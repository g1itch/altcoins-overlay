# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
MyPN="Bataoshi"

inherit altcoin

DESCRIPTION="Command-line JSON-RPC client for ${COIN_NAME^} crypto-currency"
HOMEPAGE="http://www.bata.io/"
SRC_URI="https://github.com/BTA-${COIN_NAME}/${MyPN}/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND+="dev-lang/yasm"

S="${WORKDIR}"/${MyPN}-${PV}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	econf --without-gui \
		  --disable-tests \
		  --without-daemon \
		  --with-utils
}

src_install() {
	newbin src/bitcoin-cli ${PN}

	newman doc/man/bitcoin-cli.1 ${PN}.1
	newbashcomp contrib/bitcoin-cli.bash-completion ${PN}
}
