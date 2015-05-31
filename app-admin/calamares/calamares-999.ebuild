# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python{3_3,3_4} )

inherit eutils cmake-utils python-r1 git-2

EGIT_BRANCH="kogaion"
EGIT_COMMIT="5805b67793b6fb2c38da66d7bb9c88e35bb528a2"
EGIT_REPO_URI="https://gitlab.com/rogentos/calamares.git
		https://github.com/Rogentos/calamares.git"

DESCRIPTION="Distribution-independent installer framework ( with Kogaionn/Sabayon support)"
HOMEPAGE="http://calamares.io"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${PN}-${PV}"

DEPEND="dev-vcs/git
	>=dev-qt/qtcore-5.4.0:5
	>=dev-qt/qtdbus-5.4.0:5
	>=dev-qt/qtgui-5.4.0:5
	>=dev-qt/qtsvg-5.4.0:5
	>=dev-qt/qtwidgets-5.4.0:5
	>=dev-cpp/yaml-cpp-0.5.1
	>=kde-frameworks/extra-cmake-modules-5.10.0"

RDEPEND=">=dev-qt/qtcore-5.4.0:5
	>=dev-qt/qtdbus-5.4.0:5
	>=dev-qt/qtgui-5.4.0:5
	>=dev-qt/qtsvg-5.4.0:5
	>=dev-qt/qtwidgets-5.4.0:5
	>=dev-cpp/yaml-cpp-0.5.1
	>=dev-libs/libatasmart-0.19
	>=kde-frameworks/kconfig-5.10.0
	>=kde-frameworks/ki18n-5.10.0
	>=kde-frameworks/kcoreaddons-5.10.0
	>=kde-frameworks/solid-5.10.0
	>=sys-block/parted-3.0
	>=sys-apps/gptfdisk-0.8.10
	sys-auth/polkit-qt[qt5]
	sys-fs/udisks:2[systemd]
	virtual/udev[systemd]"

src_prepare() {
	# If qtchooser is installed, it may break the build, because moc,rcc and uic binaries for wrong qt version may be used.
	# Setting QT_SELECT environment variable will enforce correct binaries (fix taken from vlc ebuild)
	export QT_SELECT=qt5
	
	git submodule init
	git submodule update
}

src_compile() {
	einfo "more work in progress"
}

src_install() {
	einfo "much more work in progress"
}
