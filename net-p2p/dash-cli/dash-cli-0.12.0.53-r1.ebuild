# Copyright 2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

DB_VER="4.8"

inherit bash-completion-r1 db-use autotools eutils versionator

MY_PN="dash"

DESCRIPTION="Command-line JSON-RPC client for Dash crypto-currency"
HOMEPAGE="https://www.dashpay.io/"
SRC_URI="https://github.com/dashpay/${MY_PN}/archive/v${PV}.zip -> ${MY_PN}-${PV}.zip"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="libressl"

RDEPEND="
	dev-libs/boost[threads(+)]
	!libressl? ( dev-libs/openssl:0[-bindist] )
	libressl? ( dev-libs/libressl )
	sys-libs/db:$(db_ver_to_slot "${DB_VER}")[cxx]
	>=dev-libs/leveldb-1.18-r1
"
DEPEND="${RDEPEND}
	dev-lang/yasm
	>=app-shells/bash-4.1
"

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
		doman contrib/debian/manpages/dashd.1 ${PN}.1

	newbashcomp contrib/dashd.bash-completion ${PN}
}
