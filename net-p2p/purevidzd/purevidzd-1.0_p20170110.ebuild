# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
COIN_SYMBOL="VIDZ"
MY_PN=PureVidzd

inherit altcoin

HOMEPAGE="http://purevidz.net/"
COMMIT="d3e3f9bd70f9b3dc5c5904a52e44024381728d3b"
SRC_URI="https://github.com/purevidz/vidzcoin/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="examples ipv6 upnp +wallet"

DEPEND+="virtual/awk"
RDEPEND+="virtual/bitcoin-leveldb"

S="${WORKDIR}"/vidzcoin-${COMMIT}


src_prepare() {
	epatch "${FILESDIR}"/1.0-sys_leveldb.patch
	altcoin_src_prepare
}

src_install() {
	mv src/${MY_PN} src/${PN}
	altcoin_src_install
	local manpath=contrib/debian/manpages
	newman ${manpath}/${MY_PN}.1 ${PN}.1
	newman ${manpath}/${MY_PN:0:-1}.conf.5 ${COIN_NAME}.conf.5
}
