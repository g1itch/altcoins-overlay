# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="UNB"

inherit versionator altcoin

MyPN=UnbreakableCoin_2017
COMMIT="745488e2815f16264d02bb078b4797e71d4860f5"
HOMEPAGE="http://www.unbreakablecoin.com/"
SRC_URI="https://github.com/jimblasko/${MyPN}/archive/${COMMIT}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples upnp +wallet libressl"

RDEPEND+="
	>=dev-libs/leveldb-1.18-r1
"

S="${WORKDIR}"/${MyPN}-${COMMIT}

src_prepare() {
	rm -r src/leveldb
	epatch "${FILESDIR}"/$(get_version_component_range 1-2)-sys_leveldb.patch
	eautoreconf
	chmod +x share/genbuild.sh
}

src_configure() {
	append-ldflags -Wl,-z,noexecstack

	local my_econf=
	has test $FEATURES || my_econf="${my_econf} --disable-tests"
	econf \
		$(use_with libressl) \
		$(use_with upnp miniupnpc) \
		$(use_enable upnp upnp-default) \
		$(use_enable wallet) \
		--disable-ccache \
		--disable-static \
		--with-system-leveldb \
		--without-utils \
		--without-libs \
		--without-gui \
		--with-daemon \
		${my_econf}
}
