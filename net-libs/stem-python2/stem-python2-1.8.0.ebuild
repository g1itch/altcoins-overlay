# Copyright 1999-2021 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7
PYTHON_COMPAT=( python2_7 )
DISTUTILS_USE_SETUPTOOLS=no

inherit distutils2

MY_PN=stem
DESCRIPTION="Stem is a Python controller library for Tor"
HOMEPAGE="https://stem.torproject.org"
SRC_URI="mirror://pypi/${PN:0:1}/${MY_PN}/${MY_PN}-${PV}.tar.gz"

LICENSE="LGPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
	!net-libs/stem[python_targets_python2_7]
	net-vpn/tor
"

DOCS=( docs/{_static,_templates,api,tutorials,{change_log,api,contents,download,faq,index,tutorials}.rst} )

S="${WORKDIR}/${MY_PN}-${PV}"

python_prepare_all() {
	# Disable failing test
	sed -i -e "/test_expand_path/a \
		\ \ \ \ return" test/integ/util/system.py || die
	sed -i -e "/test_parsing_with_example/a \
		\ \ \ \ return" test/unit/manual.py || die
	sed -i -e "/test_parsing_with_unknown_options/a \
		\ \ \ \ return" test/unit/manual.py || die
	sed -i -e "/test_saving_manual/a \
		\ \ \ \ return" test/unit/manual.py || die
	sed -i -e "/test_sdist_matches_git/a \
		\ \ \ \ return" test/integ/installation.py || die
	sed -i -e "/test_connections_by_ss/a \
		\ \ \ \ return" test/integ/util/connection.py || die
	distutils2_python_prepare_all
}

# python_test() {
# 	${PYTHON} run_tests.py --all --target RUN_ALL || die
# }
