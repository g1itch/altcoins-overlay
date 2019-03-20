# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="AUR"

inherit versionator altcoin

HOMEPAGE="http://auroracoin.is/"
SRC_URI="https://github.com/aurarad/${COIN_NAME}/archive/${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

LICENSE="MIT ISC GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="examples upnp +wallet"

RDEPEND+="
	>=dev-libs/leveldb-1.18-r1
"

S="${WORKDIR}"/${COIN_NAME^}-${PV}


src_prepare() {
	local PVM=$(get_version_component_range 1-2)
	rm -r src/leveldb
	epatch "${FILESDIR}"/${PVM}-sys_leveldb.patch
	eautoreconf
}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	local my_econf=
	has test $FEATURES || my_econf="${my_econf} --disable-tests"
	econf \
		$(use_with upnp miniupnpc) \
		$(use_enable upnp upnp-default) \
		$(use_enable wallet) \
		--disable-ccache \
		--with-system-leveldb \
		--without-cli \
		--without-gui \
		--with-daemon \
		${my_econf}
}
