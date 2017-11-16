# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="DGC"

inherit versionator altcoin

HOMEPAGE="https://bitcointalk.org/index.php?topic=785601.0"
SRC_URI="https://github.com/lomtax/${COIN_NAME}/archive/${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples upnp +wallet"

RDEPEND+=">=dev-libs/leveldb-1.18-r1"
DEPEND+="dev-lang/yasm"


src_prepare() {
	rm -r src/leveldb
	epatch "${FILESDIR}"/3.0-sys_leveldb.patch
	eautoreconf
}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	local my_econf=
	has test $FEATURES || my_econf="${my_econf} --disable-tests"
	econf --without-gui \
		  --without-cli \
		  --with-system-leveldb \
		  $(use_enable wallet) \
		  $(use_enable upnp upnp-default) \
		  $(use_with upnp miniupnpc) \
		  ${my_econf}
}
