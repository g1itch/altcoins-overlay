# Copyright 2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

inherit base versionator altcoin

MY_PN="digibyte"
MY_PV="4.03"
DESCRIPTION="Digibyte crypto-currency p2p network daemon"
HOMEPAGE="http://digibyte.co/"
SRC_URI="https://github.com/${MY_PN}/${MY_PN}/archive/v${MY_PV}.zip -> ${MY_PN}-${PV}.zip"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples upnp +wallet"

RDEPEND+="
	>=dev-libs/leveldb-1.18-r1
	dev-libs/libsecp256k1
"
DEPEND+="dev-lang/yasm"

S="${WORKDIR}/${MY_PN}-${MY_PV}"

src_prepare() {
	epatch "${FILESDIR}"/$(get_version_component_range 1-2)-sys_leveldb.patch
	eautoreconf
	rm -r src/leveldb
}

src_configure() {
	local my_econf=
	hasq test $FEATURES && my_econf="${my_econf} --enable-tests"
	CXXFLAGS+=" -I. -I$(db_includedir "${DB_VER}")"
	econf --with-gui=no \
		  --without-cli \
		  --with-system-leveldb \
		$(use_enable wallet) \
		$(use_with upnp miniupnpc) \
		${my_econf}
}

src_compile() {
	base_src_compile
}
