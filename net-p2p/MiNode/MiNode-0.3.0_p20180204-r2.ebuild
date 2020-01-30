# Copyright 2019-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=6

PYTHON_COMPAT=( python3_{5,6,7} )
PYTHON_REQ_USE="ssl,ipv6"

inherit distutils-r1 versionator

DESCRIPTION="Python 3 implementation of the Bitmessage protocol."
COMMIT="f0f277f731ffe1eb2295909fac8c3593e18681c7"
HOMEPAGE="https://github.com/TheKysek/${PN}"
SRC_URI="${HOMEPAGE}/archive/${COMMIT}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="libressl"
REQUIRED_USE="${PYTHON_REQUIRED_USE}"

DEPEND="${PYTHON_DEPS}"

RDEPEND="${DEPEND}
	!libressl? ( dev-libs/openssl:0[-bindist] )
	libressl? ( dev-libs/libressl )
"

S="${WORKDIR}"/${PN}-${COMMIT}

PVM=$(get_version_component_range 1-2)
PATCHES=(
	"${FILESDIR}"/${PVM}-setup.patch
)

src_install () {
	distutils-r1_src_install
	dodoc README.md

	local DN=${PN,,}
	newconfd "${FILESDIR}"/${DN}.confd ${DN}
	newinitd "${FILESDIR}"/${DN}.initd ${DN}
}
