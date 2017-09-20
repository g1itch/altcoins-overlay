# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="DMD"

inherit versionator altcoin

MY_PN=${COIN_SYMBOL}v3
HOMEPAGE="http://bit.diamonds/"
SRC_URI="https://github.com/LIMXTEC/${MY_PN}/archive/${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS=""
IUSE="examples upnp libressl +wallet zmq"

RDEPEND+=">=dev-libs/leveldb-1.18-r1
	zmq? ( net-libs/zeromq )"
DEPEND+="dev-lang/yasm"

S="${WORKDIR}"/${MY_PN}-${PV}

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
		  $(use_enable zmq) \
		  $(use_enable wallet) \
		  $(use_enable upnp upnp-default) \
		  $(use_with upnp miniupnpc) \
		  $(use_with libressl) \
		  ${my_econf}
}

src_install() {
	altcoin_src_install
	local manpath=contrib/debian/manpages
	newman ${manpath}/pivxd.1 ${PN}.1
	newman ${manpath}/pivx.conf.5 ${COIN_NAME}.conf.5
}
