# Copyright 2018-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="XMY"

inherit altcoin

DESCRIPTION="Command-line JSON-RPC client for ${COIN_NAME^} crypto-currency"
HOMEPAGE="http://myriadcoin.org/"
SRC_URI="https://github.com/myriadteam/${COIN_NAME}/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND+="dev-lang/yasm"

S="${WORKDIR}"/${COIN_NAME}-${PV}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	econf --disable-tests --disable-bench \
		  --without-daemon \
		  --without-libs \
		  --without-gui \
		  --with-utils
}

src_install() {
	dobin src/${PN}
	newman doc/man/bitcoin-cli.1 ${PN}.1
	newbashcomp contrib/bitcoin-cli.bash-completion ${PN}
}
