# © 2021 Herbert Magaya <herbert at magaya dot co dot za>
# Distributed under the terms of the MIT License

EAPI=7

inherit font

DESCRIPTION="Typeface designed for source code"
HOMEPAGE="https://github.com/ryanoasis/nerd-fonts"
SRC_URI="https://github.com/ryanoasis/nerd-fonts/releases/download/v${PV}/SourceCodePro.zip"
S="${WORKDIR}"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 arm arm64 ~ppc64 ~riscv x86"
IUSE=""

RESTRICT="binchecks strip"

FONT_SUFFIX="ttf"
