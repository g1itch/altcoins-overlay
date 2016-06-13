# Copyright 2015-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
MY_PV="4.03"

inherit altcoin bash-completion-r1 versionator

DESCRIPTION="Command-line JSON-RPC client for Digibyte crypto-currency"
HOMEPAGE="http://digibyte.co/"
SRC_URI="https://github.com/${COIN_NAME}/${COIN_NAME}/archive/v${MY_PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND+=">=dev-libs/leveldb-1.18-r1"
DEPEND+="dev-lang/yasm"


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
		  --with-cli \
		  --with-system-leveldb
}

src_install() {
	dobin src/${PN}

	has_version "net-p2p/digibyted" ||
		newman contrib/debian/manpages/${COIN_NAME}d.1 ${PN}.1

	newbashcomp contrib/${COIN_NAME}d.bash-completion ${PN}
}
