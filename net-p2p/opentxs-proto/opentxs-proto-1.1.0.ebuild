# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

PYTHON_COMPAT=( python{2_7,3_4} )

inherit cmake-utils python-single-r1

DESCRIPTION="Open-Transactions Canonical Protbuf Definition Library"
HOMEPAGE="http://opentransactions.org/"
SRC_URI="https://github.com/Open-Transactions/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MPL-2.0"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="python"

DEPEND=">=dev-libs/protobuf-2.6
	python? ( ${PYTHON_DEPS} >=dev-lang/swig-2 )"

REQUIRED_USE="python? ( ${PYTHON_REQUIRED_USE} )"

PATCHES=( "${FILESDIR}"/$(get_version_component_range 1-2)-version.patch )


src_configure() {
	local mycmakeargs=( )

	# It'll not work if PYTHON_SINGLE_TARGET isn't default python
	if use python; then
		mycmakeargs+=(-DPYTHON=ON)
	fi
	cmake-utils_src_configure
}
