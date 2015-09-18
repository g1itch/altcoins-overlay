# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

inherit autotools flag-o-matic

MY_PV=${PV}-scrypt.2
DESCRIPTION="Bitcoin FPGA/ASIC miner in C with support for Gridseed and Zeus ASICs"
HOMEPAGE="https://github.com/dmaxl/${PN}"
SRC_URI="https://codeload.github.com/dmaxl/${PN}/zip/v${MY_PV} -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

HARDWARE="ants1 ants2 avalon bab bflsc bitforce bitfury bitmine_A1 cointerra drillbit gridseed hashfast icarus klondike knc avalon2 minion modminer spondoolies zeus"
IUSE="doc examples hardened +libusb ncurses +udev scrypt ${HARDWARE}"

REQUIRED_USE="|| ( ${HARDWARE} )
	scrypt? ( || ( gridseed zeus ) )
	avalon? ( libusb )
	bflsc? ( libusb )
	bitforce? ( libusb )
	bitfury? ( libusb )
	icarus? ( libusb )
	klondike? ( libusb )
	modminer? ( libusb )
	gridseed? ( libusb )
	zeus? ( scrypt libusb )"

DEPEND="net-misc/curl
	dev-libs/jansson
	libusb? ( virtual/libusb:1 )
	ncurses? ( sys-libs/ncurses )
	udev? ( virtual/libudev )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	eautoreconf
}

src_configure() {
	use hardened && append-cflags "-nopie"

	local myconf=(
		--with-system-libusb
		$(use_with ncurses curses)
		$(use_enable scrypt)
	)
	for dev in ${HARDWARE}; do
		myconf+=($(use_enable $dev))
	done

	econf "${myconf[@]}"
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
		dodoc AUTHORS NEWS README API-README
		use bitforce || use icarus || use modminer && dodoc FPGA-README
		use ants1 || use ants2 || use avalon || use avalon2 ||
			use bab || use bflsc || use bitfury || use bitmine_A1 ||
			use cointerra || use drillbit || use gridseed ||
			use hashfast || use icarus || use klondike || use knc ||
			use minion || use spondoolies || use zeus &&
				dodoc ASIC-README
	fi

	if use modminer; then
		insinto /usr/lib/cgminer/modminer
		doins bitstreams/*.ncd
		dodoc bitstreams/COPYING_fpgaminer
	fi

	if use examples; then
		docinto examples
		dodoc api-example.php miner.php API.java api-example.c api-example.py example.conf
	fi
}
