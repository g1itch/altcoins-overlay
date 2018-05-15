# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="BTX"

inherit altcoin

HOMEPAGE="http://bitcore.cc/"
SRC_URI="https://github.com/LIMXTEC/${COIN_NAME}/archive/${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"

S="${WORKDIR}"/BitCore-${PV}


src_configure() {
	mv doc/man/litecoin-cli.1 doc/man/${PN}.1
	mv doc/man/litecoin-tx.1 doc/man/bitcore-tx.1
	econf --disable-tests --disable-bench \
		  --without-gui \
		  --without-libs \
		  --without-daemon \
		  --with-utils
}

src_install() {
	dobin src/${PN}
}
