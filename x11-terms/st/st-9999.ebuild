# © 2021 Herbert Magaya <herbert at magaya dot co dot za>
# Distributed under the terms of the MIT License

EAPI=7
inherit desktop git-r3 multilib toolchain-funcs

DESCRIPTION="My highly customized fork of st, simple terminal implementation for X"
HOMEPAGE="https://github.com/sarrost/st"
EGIT_REPO_URI="https://github.com/sarrost/st"

LICENSE="MIT"
SLOT="0"
KEYWORDS=""
#S="$S/src"

RDEPEND="
	>=sys-libs/ncurses-6.0:0=
	media-libs/fontconfig
	x11-libs/libX11
	x11-libs/libXft
"
DEPEND="
	${RDEPEND}
	virtual/pkgconfig
	x11-base/xorg-proto
"

src_prepare() {
	default

	sed -i \
		-e "/^X11LIB/{s:/usr/X11R6/lib:/usr/$(get_libdir)/X11:}" \
		-e '/^STLDFLAGS/s|= .*|= $(LDFLAGS) $(LIBS)|g' \
		-e '/^X11INC/{s:/usr/X11R6/include:/usr/include/X11:}' \
		config.mk || die
	sed -i \
		-e '/tic/d' \
		Makefile || die
}

src_configure() {
	sed -i \
		-e "s|pkg-config|$(tc-getPKG_CONFIG)|g" \
		config.mk || die

	tc-export CC
}

src_install() {
	emake DESTDIR="${D}" PREFIX="${EPREFIX}"/usr install
}
