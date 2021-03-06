# Copyright 2016-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="FLO"
MY_PN=${COIN_SYMBOL,,}

inherit altcoin

DESCRIPTION="Command-line JSON-RPC client for ${COIN_NAME^} crypto-currency"
HOMEPAGE="http://florincoin.org/"
SRC_URI="https://github.com/${COIN_SYMBOL}blockchain/${COIN_SYMBOL}/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND+="dev-lang/yasm"

S="${WORKDIR}"/${MY_PN}-${PV}

src_configure() {
	econf --disable-tests --disable-bench \
		  --without-daemon \
		  --without-libs \
		  --without-gui \
		  --with-utils
}

src_install() {
	dobin src/${MY_PN}-cli
	dosym "${EPREFIX}"/usr/bin/${MY_PN}-cli "${EPREFIX}"/usr/bin/${PN}

	has_version "net-p2p/${COIN_NAME}d" ||
		newman contrib/debian/manpages/${COIN_NAME}d.1 ${PN}.1

	newbashcomp contrib/bitcoind.bash-completion ${PN}
}
