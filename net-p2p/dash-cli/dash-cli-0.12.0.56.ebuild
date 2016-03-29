# Copyright 2015-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

inherit altcoin bash-completion-r1 versionator

MY_PN="dash"

DESCRIPTION="Command-line JSON-RPC client for Dash crypto-currency"
HOMEPAGE="https://www.dashpay.io/"
SRC_URI="https://github.com/dashpay/${MY_PN}/archive/v${PV}.zip -> ${MY_PN}-${PV}.zip"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="libressl"

RDEPEND+="
	>=dev-libs/leveldb-1.18-r1
"
DEPEND+="dev-lang/yasm"

S="${WORKDIR}/${MY_PN}-${PV}"

src_prepare() {
	rm -r src/leveldb
	epatch "${FILESDIR}"/$(get_version_component_range 1-2)-sys_leveldb.patch
	eautoreconf
}

src_configure() {
	CXXFLAGS+=" -I. -I$(db_includedir "${DB_VER}")"
	econf --with-gui=no \
		  --disable-tests \
		  --without-daemon \
		  --without-libs \
		  --with-utils \
		  --with-system-leveldb
}

src_install() {
	dobin src/${PN}

	has_version "net-p2p/dashd" ||
		newman contrib/debian/manpages/${MY_PN}d.1 ${PN}.1

	newbashcomp contrib/${MY_PN}d.bash-completion ${PN}
}
