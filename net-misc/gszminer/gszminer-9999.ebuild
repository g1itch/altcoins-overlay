# Copyright 2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

inherit autotools flag-o-matic git-r3

DESCRIPTION="A highly specialized miner for Gridseed and Zeus ASICs"
HOMEPAGE="https://github.com/slax0r/${PN}"
EGIT_REPO_URI="${HOMEPAGE}.git"

LICENSE="GPL-3+"
SLOT="0"
KEYWORDS=""

HARDWARE="gridseed zeus"
IUSE="doc examples hardened ncurses +udev scrypt ${HARDWARE}"

REQUIRED_USE="|| ( ${HARDWARE} )"

DEPEND="net-misc/curl
	virtual/libusb:1
	ncurses? ( sys-libs/ncurses )"
RDEPEND="${DEPEND}
	dev-libs/jansson
	udev? ( virtual/libudev )"


src_configure() {
	use hardened && append-cflags "-nopie"

	econf --with-system-libusb \
		$(use_with ncurses curses) \
		$(use_enable scrypt) \
		$(use_enable gridseed) \
		$(use_enable zeus)
	# sanitize directories (is this still needed?)
	sed -i 's~^\(\#define CGMINER_PREFIX \).*$~\1"'"${EPREFIX}/usr/lib/cgminer"'"~' config.h
}

src_install() {
	dobin ${PN}

	newinitd "${FILESDIR}"/${PN}.initd ${PN}

	if use udev; then
		insinto /lib/udev/rules.d
		doins 01-cgminer.rules
	fi

	if use doc; then
		pushd docs >/dev/null
		dodoc AUTHORS NEWS README API-README ASIC-README
	fi

	if use examples; then
		popd >/dev/null
		dodoc example.conf
		pushd API >/dev/null
		docinto examples
		dodoc api-example.php miner.php API.java api-example.c api-example.py
	fi
}
