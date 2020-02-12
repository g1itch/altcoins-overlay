# Copyright 2016-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit versionator altcoin

DESCRIPTION="Command-line JSON-RPC client for Feathercoin crypto-currency"
HOMEPAGE="http://feathercoin.com/"
SRC_URI="https://github.com/${COIN_NAME}/${COIN_NAME}/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}"/${COIN_NAME^}-${MY_PV}

src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-missing-include.patch
	eautoreconf
}

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

	newman doc/man/${PN}.1 ${PN}.1
	newbashcomp contrib/bitcoin-cli.bash-completion ${PN}
}
