# Copyright 2015-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="DASH"

inherit versionator altcoin

HOMEPAGE="https://www.dash.org/"
SRC_URI="https://github.com/dashpay/${COIN_NAME}/archive/v${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples upnp +wallet libressl"

RDEPEND+="
	>=dev-libs/leveldb-1.18-r1
"
DEPEND+="dev-lang/yasm"


src_prepare() {
	rm -r src/leveldb
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	eautoreconf
}

src_configure() {
	local my_econf=
	hasq test $FEATURES && my_econf="${my_econf} --enable-tests"
	CXXFLAGS+=" -I. -I$(db_includedir "${DB_VER}")"
	econf --with-gui=no \
		  --without-libs \
		  --without-utils \
		  --with-system-leveldb \
		$(use_enable wallet) \
		$(use_with upnp miniupnpc) \
		$(use_with libressl) \
		${my_econf}
}
