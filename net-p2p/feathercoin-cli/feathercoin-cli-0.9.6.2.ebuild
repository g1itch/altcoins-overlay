# Copyright 2016-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit altcoin

DESCRIPTION="Command-line JSON-RPC client for Feathercoin crypto-currency"
HOMEPAGE="http://feathercoin.com/"
SRC_URI="https://github.com/${COIN_NAME}/${COIN_NAME}/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND+="dev-lang/yasm"

S="${WORKDIR}"/${COIN_NAME^}-${PV}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	econf --without-gui \
		  --disable-tests \
		  --without-daemon \
		  --with-cli
}

src_install() {
	dobin src/${PN}

	newman contrib/debian/manpages/${PN}.1 ${PN}.1
	newbashcomp contrib/bitcoind.bash-completion ${PN}
}
