# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="DMD"

inherit altcoin versionator

MY_PN=${COIN_SYMBOL}v3
DESCRIPTION="Command-line JSON-RPC client for BitSend crypto-currency"
HOMEPAGE="http://bit.diamonds/"
SRC_URI="https://github.com/LIMXTEC/${MY_PN}/archive/${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS=""

S="${WORKDIR}"/${MY_PN}-${PV}

src_configure() {
	econf --without-gui \
		  --disable-tests \
		  --without-libs \
		  --without-daemon \
		  --with-utils
}

src_install() {
	dobin src/${PN}

	has_version "net-p2p/${COIN_NAME}d" ||
		newman contrib/debian/manpages/pivxd.1 ${PN}.1

	newbashcomp contrib/diamondd.bash-completion ${PN}
}
