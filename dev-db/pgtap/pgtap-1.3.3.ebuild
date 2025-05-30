# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

POSTGRES_COMPAT=( {12..17} )

inherit postgres-multi

DESCRIPTION="Unit testing for PostgreSQL"
HOMEPAGE="https://pgtap.org/"
SRC_URI="https://api.pgxn.org/dist/${PN}/${PV}/${P}.zip"

LICENSE="POSTGRESQL"
SLOT="0"
KEYWORDS="amd64"

DEPEND="${POSTGRES_DEP}
		app-arch/unzip
		dev-perl/TAP-Parser-SourceHandler-pgTAP
"
RDEPEND="${DEPEND}"

# Tests requires a running database that match up with the current
# testing slot. Won't run from ${ED}, want's to install too early.
RESTRICT="test"

src_configure() {
	:
}

src_install() {
	postgres-multi_src_install

	rm -r "${ED}"/usr/share/doc/postgresql* || die "Failed to remove improper doc locations"
	dodoc doc/pgtap.mmd
}
