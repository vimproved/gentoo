# Copyright 2022-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

DISTUTILS_USE_PEP517=flit
PYTHON_COMPAT=( pypy3_11 python3_{11..14} python3_1{3t,4t} )

inherit distutils-r1 pypi

DESCRIPTION="Canonical source for classifiers on PyPI (pypi.org)"
HOMEPAGE="
	https://github.com/pypa/trove-classifiers/
	https://pypi.org/project/trove-classifiers/
"

LICENSE="Apache-2.0"
SLOT="0"
KEYWORDS="~alpha amd64 arm arm64 hppa ~loong ~m68k ~mips ppc ppc64 ~riscv ~s390 sparc x86 ~amd64-linux ~x86-linux ~arm64-macos ~ppc-macos ~x64-macos ~x64-solaris"

distutils_enable_tests pytest

src_configure() {
	grep -q 'build-backend = "setuptools' pyproject.toml ||
		die "Upstream changed build-backend, recheck"
	# write a custom pyproject.toml to ease hatchling bootstrap
	cat > pyproject.toml <<-EOF || die
		[build-system]
		requires = ["flit_core >=3.2,<4"]
		build-backend = "flit_core.buildapi"

		[project]
		name = "trove-classifiers"
		version = "${PV}"
		description = "Canonical source for classifiers on PyPI (pypi.org)."

		[project.scripts]
		trove-classifiers = "trove_classifiers.__main__:cli"
	EOF
}

python_test() {
	epytest
	"${EPYTHON}" -m tests.lib || die
}
