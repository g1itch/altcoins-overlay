# Copyright 2017-2018 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

MY_PN=dns-zone-file-py
DESCRIPTION="Blockstack DNS Zone File Converter"
HOMEPAGE="http://blockstack.org/"
COMMIT="5fe293bf11e5693de6099e671bd214d6d6e59a6f"
SRC_URI="https://github.com/blockstack/${MY_PN}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
KEYWORDS="~x86 ~amd64"
SLOT="0"

DEPEND="dev-python/setuptools"

S="${WORKDIR}"/zone-file-py-${COMMIT}

src_install() {
	rm -rf "${S}"/tests || die
	distutils-r1_src_install
}

python_install () {
	rm -rf "${BUILD_DIR}"/lib/tests || die
	distutils-r1_python_install
}
