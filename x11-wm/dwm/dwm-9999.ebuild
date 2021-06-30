# © 2021 Herbert Magaya <herbert at magaya dot co dot za>
# Distributed under the terms of the MIT License

EAPI=7
inherit git-r3 toolchain-funcs

DESCRIPTION="My highly customized fork of dwm, a dynamic window manager for X11"
HOMEPAGE="https://github.com/sarrost/dwm"
EGIT_REPO_URI="https://github.com/sarrost/dwm"

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
DEPEND="
	x11-base/xorg-proto
"

src_prepare() {
	default

	# Modify flags to use make.conf flags
	sed -i \
		-e "s/ -Os / /" \
		-e "/^\(LDFLAGS\|CFLAGS\|CPPFLAGS\)/{s| = | += |g;s|-s ||g}" \
		config.mk || die
}

src_compile() {
	emake CC=$(tc-getCC) dwm
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}/usr" install
}
