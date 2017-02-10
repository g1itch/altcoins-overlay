# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

PYTHON_COMPAT=( python{3_4,3_5} )

inherit autotools python-r1

DESCRIPTION="A C++11 Distributed Hash Table implementation"
HOMEPAGE="https://github.com/savoirfairelinux/${PN}"
SRC_URI="${HOMEPAGE}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="doc static python"

DEPEND=">=dev-libs/msgpack-1.2
	net-libs/gnutls
	doc? ( app-doc/doxygen )
	python? ( ${PYTHON_DEPS}
			  >=dev-python/cython-0.24.1[${PYTHON_USEDEP}] )"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

src_prepare() {
	eautoreconf
}

src_configure() {
	local my_econf=
	econf \
		$(use_enable doc) \
		$(use_enable static) \
		$(use_enable python) \
		${my_econf}
}
