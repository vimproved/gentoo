# Copyright 1999-2025 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=8

inherit autotools

DESCRIPTION="Scanner Access Now Easy"
HOMEPAGE="http://www.sane-project.org"
SRC_URI="https://salsa.debian.org/debian/sane-frontends/-/archive/upstream/${PV}/${PN}-upstream-${PV}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm64 ppc ppc64 sparc x86"
IUSE="gimp gtk"
REQUIRED_USE="gimp? ( gtk )"

DEPEND="
	media-gfx/sane-backends
	gimp? ( media-gfx/gimp:0/2 )
	gtk? (
		dev-libs/glib:2
		x11-libs/gtk+:2
	)
"
RDEPEND="${DEPEND}"

DOCS=( AUTHORS Changelog NEWS PROBLEMS README )

PATCHES=(
	"${FILESDIR}/MissingCapsFlag.patch"
	"${FILESDIR}/${PN}-1.0.14-c99.patch"
)

S="${WORKDIR}"/"${PN}"-upstream-"${PV}"

src_prepare() {
	default

	# Needed for C99 patch (acinclude hack to avoid BDEPEND on gtk+, gimp)
	cat "${FILESDIR}"/gtk-2.0.m4 >> acinclude.m4 || die
	cat "${FILESDIR}"/gimp-2.0.m4 >> acinclude.m4 || die
	eautoreconf
}

src_configure() {
	local myeconfargs=(
		--datadir=/usr/share/misc
		$(use_enable gimp)
		$(use_enable gtk gtk2)
		$(use_enable gtk guis)
	)
	econf "${myeconfargs[@]}"
}

src_install() {
	emake DESTDIR="${D}" install

	# link xscanimage so it is seen as a plugin in gimp
	if use gimp; then
		local plugindir
		if type gimptool &>/dev/null; then
			plugindir="$(gimptool --gimpplugindir)/plug-ins"
		elif type gimptool-2.0 &>/dev/null; then
			plugindir="$(gimptool-2.0 --gimpplugindir)/plug-ins"
		elif type gimptool-2.99 &>/dev/null; then
			plugindir="$(gimptool-2.99 --gimpplugindir)/plug-ins"
		else
			die "Can't find GIMP plugin directory."
		fi
		dodir "${plugindir#${EPREFIX}}"
		dosym ../../../../bin/xscanimage "${plugindir#${EPREFIX}}"/xscanimage
	fi

	einstalldocs
}
