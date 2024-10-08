# Copyright 1999-2024 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit toolchain-funcs

DESCRIPTION="Atmel AVR Assembler"
HOMEPAGE="https://github.com/hsoft/avra"
SRC_URI="https://github.com/hsoft/avra/archive/${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~ppc ~x86"

src_compile() {
	emake \
		CC="$(tc-getCC)" \
		PREFIX=/usr \
		CFLAGS="${CFLAGS} \$(CDEFS)" \
		LDFLAGS="${LDFLAGS}"
}

src_install() {
	emake PREFIX=/usr DESTDIR="${ED}" install
	dodoc {AUTHORS,CHANGELOG.md,README.md,USAGE.md}
}
