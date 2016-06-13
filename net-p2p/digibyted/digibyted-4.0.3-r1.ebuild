# Copyright 2015-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="DGB"
MY_PV="4.03"

inherit versionator altcoin

HOMEPAGE="http://digibyte.co/"
SRC_URI="https://github.com/${COIN_NAME}/${COIN_NAME}/archive/v${MY_PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples upnp +wallet"

RDEPEND+="
	>=dev-libs/leveldb-1.18-r1
	dev-libs/libsecp256k1
"
DEPEND+="dev-lang/yasm"


src_prepare() {
	rm -r src/leveldb
	epatch "${FILESDIR}"/$(get_version_component_range 1-2)-sys_leveldb.patch
	eautoreconf
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
