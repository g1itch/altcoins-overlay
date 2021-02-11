# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

DISTUTILS_USE_SETUPTOOLS=rdepend
PYTHON_COMPAT=( python2_7 )

inherit distutils2

DESCRIPTION="QR Code generator on top of PIL"
HOMEPAGE="https://pypi.org/project/qrcode/"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="BSD"
SLOT="0"
KEYWORDS="amd64 x86"

# optional deps:
# - pillow and lxml for svg backend, set as hard deps
RDEPEND="
	dev-python/six-python2
	dev-python/lxml-python2
	dev-python/pillow-python2"

distutils_enable_tests unittest

src_install() {
	distutils2_src_install
	doman doc/qr.1
}
