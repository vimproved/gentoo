# Copyright 1999-2022 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

# ebuild generated by hackport 0.7.1.1.9999

CABAL_FEATURES="lib profile haddock hoogle hscolour test-suite"
CABAL_HACKAGE_REVISION="1"
inherit haskell-cabal

DESCRIPTION="Common quickcheck instances"
HOMEPAGE="https://github.com/haskellari/qc-instances"
SRC_URI="https://hackage.haskell.org/package/${P}/${P}.tar.gz
	https://hackage.haskell.org/package/${P}/revision/${CABAL_HACKAGE_REVISION}.cabal -> ${PF}.cabal"

LICENSE="BSD"
SLOT="0/${PV}"
KEYWORDS="~amd64 ~ppc64 ~x86"

RDEPEND=">=dev-haskell/case-insensitive-1.2.0.4:=[profile?] <dev-haskell/case-insensitive-1.3:=[profile?]
	>=dev-haskell/data-fix-0.3:=[profile?] <dev-haskell/data-fix-0.4:=[profile?]
	>=dev-haskell/hashable-1.2.7.0:=[profile?] <dev-haskell/hashable-1.5:=[profile?]
	>=dev-haskell/integer-logarithms-1.0.3:=[profile?] <dev-haskell/integer-logarithms-1.1:=[profile?]
	>=dev-haskell/old-time-1.1.0.0:=[profile?] <dev-haskell/old-time-1.2:=[profile?]
	>=dev-haskell/onetuple-0.3:=[profile?] <dev-haskell/onetuple-0.4:=[profile?]
	>=dev-haskell/quickcheck-2.14.1:2=[profile?] <dev-haskell/quickcheck-2.14.3:2=[profile?]
	>=dev-haskell/scientific-0.3.6.2:=[profile?] <dev-haskell/scientific-0.4:=[profile?]
	>=dev-haskell/splitmix-0.0.2:=[profile?] <dev-haskell/splitmix-0.2:=[profile?]
	>=dev-haskell/strict-0.4:=[profile?] <dev-haskell/strict-0.5:=[profile?]
	>=dev-haskell/tagged-0.8.6:=[profile?] <dev-haskell/tagged-0.9:=[profile?]
	>=dev-haskell/text-short-0.1.3:=[profile?] <dev-haskell/text-short-0.2:=[profile?]
	>=dev-haskell/these-1.1.1.1:=[profile?] <dev-haskell/these-1.2:=[profile?]
	>=dev-haskell/time-compat-1.9.4:=[profile?] <dev-haskell/time-compat-1.10:=[profile?]
	>=dev-haskell/transformers-compat-0.6.5:=[profile?] <dev-haskell/transformers-compat-0.8:=[profile?]
	>=dev-haskell/unordered-containers-0.2.2.0:=[profile?] <dev-haskell/unordered-containers-0.3:=[profile?]
	>=dev-haskell/uuid-types-1.0.3:=[profile?] <dev-haskell/uuid-types-1.1:=[profile?]
	>=dev-haskell/vector-0.9:=[profile?] <dev-haskell/vector-0.13:=[profile?]
	>=dev-lang/ghc-8.4.3:=
"
DEPEND="${RDEPEND}
	>=dev-haskell/cabal-2.2.0.1
"
BDEPEND="app-text/dos2unix"

src_prepare() {
	# pull revised cabal from upstream
	cp "${DISTDIR}/${PF}.cabal" "${S}/${PN}.cabal" || die

	# Convert to unix line endings
	dos2unix "${S}/${PN}.cabal" || die

	# Apply patches *after* pulling the revised cabal
	default
}
