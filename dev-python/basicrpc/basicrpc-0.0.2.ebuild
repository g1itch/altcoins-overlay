# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
PYTHON_COMPAT=( python2_7 )

inherit distutils-r1

DESCRIPTION="A very simple Python RPC client"
HOMEPAGE="https://github.com/muneeb-ali/${PN}"
SRC_URI="mirror://pypi/${PN:0:1}/${PN}/${P}.tar.gz"

LICENSE="GPL-3"
KEYWORDS="~x86 ~amd64"
SLOT="0"

DEPEND="dev-python/setuptools"
