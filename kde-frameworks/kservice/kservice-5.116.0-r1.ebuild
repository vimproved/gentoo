# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

PVCUT=$(ver_cut 1-2)
QTMIN=5.15.9
inherit ecm frameworks.kde.org

DESCRIPTION="Advanced plugin and service introspection"

LICENSE="LGPL-2 LGPL-2.1+"
KEYWORDS="amd64 ~arm arm64 ~loong ppc64 ~riscv ~x86"
IUSE="+man"

# requires running kde environment
RESTRICT="test"

RDEPEND="
	>=dev-qt/qtdbus-${QTMIN}:5
	>=dev-qt/qtxml-${QTMIN}:5
	=kde-frameworks/kconfig-${PVCUT}*:5
	=kde-frameworks/kcoreaddons-${PVCUT}*:5
	=kde-frameworks/kdbusaddons-${PVCUT}*:5
	=kde-frameworks/ki18n-${PVCUT}*:5
"
DEPEND="${RDEPEND}
	test? ( >=dev-qt/qtconcurrent-${QTMIN}:5 )
"
BDEPEND="
	app-alternatives/lex
	app-alternatives/yacc
	man? ( >=kde-frameworks/kdoctools-${PVCUT}:5 )
"

src_configure() {
	local mycmakeargs=(
		-DAPPLICATIONS_MENU_NAME=kf5-applications.menu
		$(cmake_use_find_package man KF5DocTools)
	)

	ecm_src_configure
}
