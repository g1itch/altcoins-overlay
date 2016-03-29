# Copyright 2015-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

inherit versionator altcoin

MY_PN="dash"

DESCRIPTION="Dash crypto-currency p2p network daemon"
HOMEPAGE="https://www.dash.org/"
SRC_URI="https://github.com/dashpay/${MY_PN}/archive/v${PV}.zip -> ${MY_PN}-${PV}.zip"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples upnp +wallet libressl"

RDEPEND+="
	>=dev-libs/leveldb-1.18-r1
"
DEPEND+="dev-lang/yasm"

S="${WORKDIR}/${MY_PN}-${PV}"


src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	eautoreconf
	rm -r src/leveldb
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
