# Copyright 2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5
COIN_SYMBOL="BRO"
MY_PN=${PN^}

inherit altcoin

HOMEPAGE="http://bitrad.io/"
SRC_URI="https://github.com/the${COIN_NAME}/${COIN_NAME}/archive/${PV}.tar.gz -> ${COIN_NAME}-${PV}.tar.gz"

SLOT="0"
KEYWORDS="~x86 ~amd64"

S="${WORKDIR}"/${COIN_NAME^}-${PV}

src_configure() {
	append-ldflags -Wl,-z,noexecstack
	econf \
		--disable-ccache \
		--disable-static \
		--disable-tests \
		--disable-bench \
		--without-gui \
		--without-daemon \
		--without-libs \
		--with-utils
}

src_install() {
	dobin src/${PN}

	has_version "net-p2p/${COIN_NAME}d" ||
		newman contrib/debian/manpages/${COIN_NAME}d.1 ${PN}.1
}
