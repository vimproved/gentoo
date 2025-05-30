# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit edo toolchain-funcs

# https://fossil-scm.org/home/finfo?name=tools/makeheaders.c
# 2024-08-23
ARTIFACT_C="5f464a5a25ae45978e49e1cc230cc4c6f2fddc8f2f45a044fff02dc074a0bcf6"
# https://fossil-scm.org/home/finfo?name=tools/makeheaders.html
# 2022-03-21
ARTIFACT_HTML="262696252dc50250c896c90cc240dcd946614b9c7727902aa7606640507e9231"

DESCRIPTION="Tool that automatically generates .h files for a C or C++ programming project"
HOMEPAGE="https://www.hwaci.com/sw/mkhdr/"

SRC_URI="
	https://fossil-scm.org/home/raw/${ARTIFACT_C}?at=makeheaders.c -> makeheaders-${ARTIFACT_C}.c
	https://fossil-scm.org/home/raw/${ARTIFACT_HTML}?at=makeheaders.html  -> makeheaders-${ARTIFACT_HTML}.html
"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 ~ppc ~sparc x86"

HTML_DOCS=( "makeheaders.html" )

src_unpack() {
	mkdir "${S}" || die
	cp "${DISTDIR}"/makeheaders-${ARTIFACT_C}.c "${S}/makeheaders.c" || die
	cp "${DISTDIR}"/makeheaders-${ARTIFACT_HTML}.html "${S}/makeheaders.html" || die
}

src_compile() {
	edo $(tc-getCC) ${CFLAGS} ${CPPFLAGS} ${LDFLAGS} -o makeheaders makeheaders.c
}

src_install() {
	dobin makeheaders
	einstalldocs
}
