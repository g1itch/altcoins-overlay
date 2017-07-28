# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="UNB"

inherit altcoin

MyPN=UnbreakableCoin_2017
COMMIT="745488e2815f16264d02bb078b4797e71d4860f5"
HOMEPAGE="http://www.unbreakablecoin.com/"
SRC_URI="https://github.com/jimblasko/${MyPN}/archive/${COMMIT}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

S="${WORKDIR}"/${MyPN}-${COMMIT}

src_prepare() {
	eautoreconf
	chmod +x share/genbuild.sh
}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	econf \
		--disable-ccache \
		--disable-static \
		--disable-tests \
		--without-libs \
		--without-gui \
		--without-daemon \
		--with-utils
}

src_install() {
	dobin src/${PN}

	newman contrib/debian/manpages/bitcoind.1 ${PN}.1
	newbashcomp contrib/bitcoind.bash-completion ${PN}
}
