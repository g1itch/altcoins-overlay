# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )

inherit distutils2

MY_PN=msgpack
DESCRIPTION="MessagePack (de)serializer for Python"
HOMEPAGE="https://msgpack.org
	https://github.com/msgpack/msgpack-python/
	https://pypi.org/project/msgpack/"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+native-extensions"

RDEPEND="!dev-python/msgpack[python_targets_python2_7]"
DEPEND="
	native-extensions? (
		$(python_gen_cond_dep '>=dev-python/cython-python2-0.16' 'python*')
	)
"

S="${WORKDIR}/${MY_PN}-${PV}"

distutils_enable_tests pytest

python_prepare_all() {
	# Remove pre-generated cython files
	rm msgpack/{_packer,_unpacker,_cmsgpack}.pyx || die

	if ! use native-extensions ; then
		sed -i -e "/have_cython/s:True:False:" setup.py || die
	fi
	distutils2_python_prepare_all
}
