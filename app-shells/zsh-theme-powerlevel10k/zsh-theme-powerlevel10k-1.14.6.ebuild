# © 2021 Herbert Magaya <herbert at magaya dot co dot za>
# Distributed under the terms of the MIT License

EAPI=7

DESCRIPTION="Powerlevel10k is a theme for Zsh. It emphasizes speed, flexibility and out-of-the-box experience."
HOMEPAGE="https://github.com/romkatv/powerlevel10k"
SRC_URI="https://github.com/romkatv/powerlevel10k/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="amd64 ~x86 ~arm ~arm64 ~sparc"
IUSE=""

DEPEND="app-shells/zsh"
RDEPEND="${DEPEND}"
BDEPEND="dev-vcs/git"

S="${WORKDIR}/powerlevel10k-${PV}"

src_install() {
	insinto /usr/share/zsh-themes/powerlevel10k
	doins -r * || die "Install failed!"
}

pkg_postinst() {
	elog
	elog "Running an interactive zsh instance the first time will be slow and might"
	elog "need to be run as root. This is because gitstatus is installed during"
	elog "runtime."
	elog
}
