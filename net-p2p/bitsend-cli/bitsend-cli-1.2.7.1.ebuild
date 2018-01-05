# Copyright 2016-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="BSD"

inherit altcoin versionator

MY_PV=${COIN_SYMBOL}$(delete_all_version_separators)
DESCRIPTION="Command-line JSON-RPC client for BitSend crypto-currency"
HOMEPAGE="http://www.bitsend.info/"
SRC_URI="https://github.com/LIMXTEC/${COIN_NAME}/archive/${MY_PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS=""

S="${WORKDIR}"/BitSend-${MY_PV}

src_configure() {
	econf --without-gui \
		  --disable-tests \
		  --without-daemon \
		  --with-cli
}

src_install() {
	dobin src/${PN}

	has_version "net-p2p/${COIN_NAME}d" ||
		newman contrib/debian/manpages/limecoinxd.1 ${PN}.1

	newbashcomp contrib/bitcoind.bash-completion ${PN}
}
