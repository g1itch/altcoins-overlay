# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="BTX"

inherit altcoin

HOMEPAGE="http://bitcore.cc/"
SRC_URI="https://github.com/LIMXTEC/${COIN_NAME}/archive/${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"

S="${WORKDIR}"/BitCore-${PV}

src_configure() {
	econf --disable-tests --disable-bench \
		  --without-gui \
		  --without-libs \
		  --without-daemon \
		  --with-utils
}

src_install() {
	dobin src/${PN}
}
