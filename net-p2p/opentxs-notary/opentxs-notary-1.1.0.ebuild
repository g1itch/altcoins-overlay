# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

inherit cmake-utils

DESCRIPTION="Open Transactions - Notary"
HOMEPAGE="http://opentransactions.org/"
SRC_URI="https://github.com/Open-Transactions/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE="test"

DEPEND="net-p2p/opentxs
	test? ( dev-cpp/gtest )"

PATCHES=( "${FILESDIR}"/$(get_version_component_range 1-2)-version.patch )

src_configure() {
	rmdir deps/gtest
	use test || cmake_comment_add_subdirectory tests
	pushd deps
	cmake_comment_add_subdirectory gtest
	popd
	local mycmakeargs=( $(cmake-utils_use_build test TESTS) )
	cmake-utils_src_configure
}
