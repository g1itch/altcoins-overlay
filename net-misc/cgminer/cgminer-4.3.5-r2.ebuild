# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

inherit autotools flag-o-matic

MY_PV=${PV}-scrypt.2
DESCRIPTION="Bitcoin CPU/GPU/FPGA/ASIC miner in C with support for Gridseed and Zeus ASICs "
HOMEPAGE="https://github.com/dmaxl/${PN}"
SRC_URI="https://codeload.github.com/dmaxl/${PN}/zip/v${MY_PV} -> ${P}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

HARDWARE="avalon bflsc bitforce bitfury icarus klondike modminer opencl gridseed"
IUSE="doc examples udev hardened ncurses adl scrypt ${HARDWARE}"

REQUIRED_USE="|| ( ${HARDWARE} )
	adl? ( opencl )
	scrypt? ( || ( opencl gridseed ) )"

DEPEND="net-misc/curl
	dev-libs/jansson
	adl? ( x11-libs/amd-adl-sdk )
	ncurses? ( sys-libs/ncurses )
	opencl? ( virtual/opencl )
	avalon? ( virtual/libusb:1 )
	bflsc? ( virtual/libusb:1 )
	bitforce? ( virtual/libusb:1 )
	bitfury? ( virtual/libusb:1 )
	icarus? ( virtual/libusb:1 )
	modminer? ( virtual/libusb:1 )
	gridseed? ( virtual/libusb:1 )
	udev? ( virtual/libudev )"
RDEPEND="${DEPEND}"

S="${WORKDIR}/${PN}-${MY_PV}"

src_prepare() {
	ln -s /usr/include/ADL/* ADL_SDK/
	eautoreconf
}

src_configure() {
	use hardened && append-cflags "-nopie"

	econf $(use_with ncurses curses) \
		$(use_enable opencl) \
		$(use_enable adl) \
		$(use_enable scrypt) \
		$(use_enable avalon) \
		$(use_enable bflsc) \
		$(use_enable bitforce) \
		$(use_enable bitfury) \
		$(use_enable icarus) \
		$(use_enable klondike) \
		$(use_enable modminer) \
		$(use_enable gridseed)
	# sanitize directories (is this still needed?)
	sed -i 's~^\(\#define CGMINER_PREFIX \).*$~\1"'"${EPREFIX}/usr/lib/cgminer"'"~' config.h
}

src_install() { # How about using some make install?
	dobin ${PN}

	newinitd "${FILESDIR}"/${PN}.initd ${PN}

	if use udev; then
		insinto /lib/udev/rules.d
		use udev && doins 01-cgminer.rules
	fi

	if use doc; then
		dodoc AUTHORS NEWS README API-README
		use icarus || use bitforce || use modminer && dodoc FPGA-README
		use avalon || use bflsc || gridseed && dodoc ASIC-README
	fi

	if use modminer; then
		insinto /usr/lib/cgminer/modminer
		doins bitstreams/*.ncd
		dodoc bitstreams/COPYING_fpgaminer
	fi

	if use opencl; then
		insinto /usr/lib/cgminer
		doins *.cl
	fi

	if use examples; then
		docinto examples
		dodoc api-example.php miner.php API.java api-example.c api-example.py example.conf
	fi
}
