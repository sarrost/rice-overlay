# © 2021 Herbert Magaya <herbert at magaya dot co dot za>
# Distributed under the terms of the MIT License

EAPI=7
inherit git-r3 toolchain-funcs

DESCRIPTION="My highly customized fork of dmenu, a generic, highly customizable, and efficient menu for the X Window System"
HOMEPAGE="https://github.com/sarrost/dmenu"
EGIT_REPO_URI="https://github.com/sarrost/dmenu"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
S="$S/src"

RDEPEND="
	media-libs/fontconfig
	x11-libs/libX11
	x11-libs/libXft
	x11-libs/libXinerama
"
DEPEND="${RDEPEND}
	x11-base/xorg-proto
"
BDEPEND="
	virtual/pkgconfig
"

src_prepare() {
	default

	sed -i \
		-e "s/ -Os / /" \
		`# Remove redundant -I's` \
		-e 's/-I$(FREETYPEINC)/$(FREETYPEINC)/' \
		-e 's/-I$(X11INC)/$(X11INC)/' \
		`# Modify flags to use make.conf flags` \
		-e "/^\(LDFLAGS\|CFLAGS\|CPPFLAGS\)/{s| = | += |g;s|-s ||g}" \
		config.mk || die
}

src_compile() {
	emake CC=$(tc-getCC) \
		"FREETYPEINC=$( $(tc-getPKG_CONFIG) --cflags x11 fontconfig xft 2>/dev/null )" \
		"FREETYPELIBS=$( $(tc-getPKG_CONFIG) --libs x11 fontconfig xft 2>/dev/null )" \
		"X11INC=$( $(tc-getPKG_CONFIG) --cflags x11 2>/dev/null )" \
		"X11LIB=$( $(tc-getPKG_CONFIG) --libs x11 2>/dev/null )" \
		"XINERAMAFLAGS=$( $(tc-getPKG_CONFIG) --cflags xinerama 2>/dev/null )" \
		"XINERAMALIBS=$( $(tc-getPKG_CONFIG) --libs xinerama 2>/dev/null )"
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}
