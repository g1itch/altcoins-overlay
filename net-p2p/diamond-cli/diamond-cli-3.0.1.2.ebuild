# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="DMD"

inherit altcoin

DESCRIPTION="Command-line JSON-RPC client for BitSend crypto-currency"
HOMEPAGE="http://bit.diamonds/"
SRC_URI="https://github.com/DMDcoin/${COIN_NAME}/archive/${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"

S="${WORKDIR}"/${COIN_NAME^}-${PV}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	econf --disable-tests \
		  --without-daemon \
		  --without-libs \
		  --without-gui \
		  --with-utils
}

src_install() {
	dobin src/${PN}

	has_version "net-p2p/${COIN_NAME}d" ||
		newman contrib/debian/manpages/pivxd.1 ${PN}.1

	newbashcomp contrib/diamondd.bash-completion ${PN}
}
