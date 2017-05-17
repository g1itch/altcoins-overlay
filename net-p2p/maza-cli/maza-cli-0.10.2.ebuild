# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="MZC"

inherit versionator altcoin

HOMEPAGE="http://www.mazacoin.org/"
SRC_URI="https://github.com/${COIN_NAME}coin/${COIN_NAME}/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND+="dev-lang/yasm"


src_configure() {
	append-ldflags -Wl,-z,noexecstack
	econf --without-gui \
		  --disable-tests \
		  --without-daemon \
		  --without-libs \
		  --with-utils
}

src_install() {
	dobin src/${PN}

	has_version "net-p2p/${COIN_NAME}d" ||
		newman contrib/debian/manpages/bitcoind.1 ${PN}.1

	newbashcomp contrib/${COIN_NAME}d.bash-completion ${PN}
}
