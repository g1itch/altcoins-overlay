# Copyright 1999-2019 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=5

PYTHON_COMPAT=( python2_7 python3_{5,6,7} )

inherit distutils-r1

DESCRIPTION="Basic Python wrapper for libcanberra"
HOMEPAGE="https://github.com/psykoyiko/pycanberra/"
PCOMMIT="88c53cd44a626ede3b07dab0b548f8bcfda42867"
SRC_URI="https://github.com/psykoyiko/pycanberra/archive/${PCOMMIT}.zip -> ${P}.zip"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND="${PYTHON_DEPS}
	media-libs/libcanberra"
DEPEND="${PYTHON_DEPS}"

S="${WORKDIR}/${PN}-${PCOMMIT}"

src_prepare() {
	epatch "${FILESDIR}"/0.1-setup.patch
}
