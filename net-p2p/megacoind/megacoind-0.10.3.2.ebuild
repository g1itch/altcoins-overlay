# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="MEC"

inherit versionator altcoin

HOMEPAGE="http://www.megacoin.co.nz"
SRC_URI="https://github.com/LIMXTEC/${COIN_NAME}/archive/${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples upnp libressl +wallet"

RDEPEND+=">=dev-libs/leveldb-1.18-r1"
DEPEND+="dev-lang/yasm"

S="${WORKDIR}"/${COIN_NAME^}-${PV}

src_prepare() {
	rm -r src/leveldb
	epatch "${FILESDIR}"/$(get_version_component_range 1-2)-sys_leveldb.patch
	eautoreconf
}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	local my_econf=
	has test $FEATURES || my_econf="${my_econf} --disable-tests"
	econf --without-gui \
		  --without-libs \
		  --without-utils \
		  --with-system-leveldb \
		  $(use_enable wallet) \
		  $(use_enable upnp upnp-default) \
		  $(use_with upnp miniupnpc) \
		  $(use_with libressl) \
		  ${my_econf}
}
