# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5

inherit cmake-utils

MY_PN="ot"
DESCRIPTION="Opentxs cli program"
HOMEPAGE="http://opentransactions.org/"
SRC_URI="https://github.com/Open-Transactions/${MY_PN}/archive/${PV}.tar.gz -> ${MY_PN}-${PV}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""

DEPEND="net-p2p/opentxs"

PATCHES=( "${FILESDIR}"/$(get_version_component_range 1-2)-version.patch )

S="${WORKDIR}"/${MY_PN}-${PV}
