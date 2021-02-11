# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )

inherit distutils2

MY_PN=jsonrpclib
DESCRIPTION="python implementation of the JSON-RPC spec (1.0 and 2.0)"
HOMEPAGE="https://github.com/tcalmant/jsonrpclib"
SRC_URI="https://github.com/tcalmant/jsonrpclib/archive/v${PV}.tar.gz -> ${MY_PN}-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="!dev-python/jsonrpclib[python_targets_python2_7]"

S="${WORKDIR}/${MY_PN}-${PV}"
