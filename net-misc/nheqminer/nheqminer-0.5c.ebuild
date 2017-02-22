# Copyright 2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header$

EAPI=5
inherit cmake-utils

DESCRIPTION="Equihash miner for NiceHash"
HOMEPAGE="https://www.nicehash.com/"
SRC_URI="https://github.com/nicehash/${PN}/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="cuda"

DEPEND="dev-libs/boost[static-libs]
	cuda? (
		>=dev-util/nvidia-cuda-toolkit-2.1
		>=x11-drivers/nvidia-drivers-180.22
	)"
RDEPEND="${DEPEND}"


src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_use cuda CUDA_DJEZO)
		-DUSE_CPU_XENONCAT=OFF
		-DUSE_CPU_TROMP=ON
	)
	cmake-utils_src_configure
}

src_install() {
	dobin ${BUILD_DIR}/${PN}
	newconfd "${FILESDIR}"/${PN}.confd ${PN}
	newinitd "${FILESDIR}"/${PN}.initd ${PN}
}
