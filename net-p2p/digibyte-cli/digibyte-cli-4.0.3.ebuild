# Copyright 2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

inherit altcoin bash-completion-r1 versionator

MY_PN="digibyte"
MY_PV="4.03"
DESCRIPTION="Command-line JSON-RPC client for Digibyte crypto-currency"
HOMEPAGE="http://digibyte.co/"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/v${MY_PV}.zip -> ${MY_PN}-${PV}.zip"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

RDEPEND+=">=dev-libs/leveldb-1.18-r1"
DEPEND+="dev-lang/yasm"

S="${WORKDIR}/${MY_PN}-${MY_PV}"

src_prepare() {
	epatch "${FILESDIR}"/$(get_version_component_range 1-2)-sys_leveldb.patch
	eautoreconf
	rm -r src/leveldb
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
		newman contrib/debian/manpages/${MY_PN}d.1 ${PN}.1

	newbashcomp contrib/${MY_PN}d.bash-completion ${PN}
}
