# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python3_3 )

inherit eutils cmake-utils python-r1 git-2

EGIT_BRANCH="kogaion"
EGIT_COMMIT="61da2df0de3a00d6b8cfcfdcd7e1c674c2b3aa21"
EGIT_REPO_URI="https://github.com/Rogentos/calamares.git"

DESCRIPTION="Distribution-independent installer framework"
HOMEPAGE="http://calamares.io"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

S="${WORKDIR}/${PN}-${PV}"

DEPEND="dev-vcs/git
	>=dev-qt/designer-5.4.0:5
	>=dev-qt/linguist-tools-5.4.0:5
	>=dev-qt/qtconcurrent-5.4.0:5
	>=dev-qt/qtcore-5.4.0:5
	>=dev-qt/qtdbus-5.4.0:5
	>=dev-qt/qtdeclarative-5.4.0:5
	>=dev-qt/qtgui-5.4.0:5
	>=dev-qt/qtnetwork-5.4.0:5
	>=dev-qt/qtopengl-5.4.0:5
	>=dev-qt/qtprintsupport-5.4.0:5
	>=dev-qt/qtscript-5.4.0:5
	>=dev-qt/qtsvg-5.4.0:5
	>=dev-qt/qttest-5.4.0:5
	>=dev-qt/qtwidgets-5.4.0:5
	>=dev-qt/qtxml-5.4.0:5
	>=dev-qt/qtxmlpatterns-5.4.0:5
	>=dev-cpp/yaml-cpp-0.5.1
	>=kde-frameworks/extra-cmake-modules-5.10.0"

RDEPEND=">=dev-qt/designer-5.4.0:5
	>=dev-qt/linguist-tools-5.4.0:5
	>=dev-qt/qtconcurrent-5.4.0:5
	>=dev-qt/qtcore-5.4.0:5
	>=dev-qt/qtdbus-5.4.0:5
	>=dev-qt/qtdeclarative-5.4.0:5
	>=dev-qt/qtgui-5.4.0:5
	>=dev-qt/qtnetwork-5.4.0:5
	>=dev-qt/qtopengl-5.4.0:5
	>=dev-qt/qtprintsupport-5.4.0:5
	>=dev-qt/qtscript-5.4.0:5
	>=dev-qt/qtsvg-5.4.0:5
	>=dev-qt/qttest-5.4.0:5
	>=dev-qt/qtwidgets-5.4.0:5
	>=dev-qt/qtxml-5.4.0:5
	>=dev-qt/qtxmlpatterns-5.4.0:5
	>=dev-cpp/yaml-cpp-0.5.1
	>=dev-libs/libatasmart-0.19
	>=kde-frameworks/kconfig-5.10.0
	>=kde-frameworks/ki18n-5.10.0
	>=kde-frameworks/kcoreaddons-5.10.0
	>=kde-frameworks/solid-5.10.0
	>=net-misc/rsync-3.1[xattr]
	>=sys-block/parted-3.0
	>=sys-apps/gptfdisk-0.8.10
	>=sys-apps/dmidecode-2.12-r1
	>=sys-fs/squashfs-tools-4.3:0[xattr]
	>=sys-power/upower-0.99.0-r1
	sys-auth/polkit-qt[qt5]
	sys-fs/udisks:2[systemd]
	virtual/udev[systemd]"

src_prepare() {
	# by default, python support is optional and calamares builds fine if is not found
	# on gentoo finding python && boost libs is sometimes problematic, and we really really
	# want python support in our package
	# this patch helps calamares to find python && boost libs and force-enables python
	epatch "${FILESDIR}/${PN}-find-gentoo-python3-boost-libs.patch"

	# If qtchooser is installed, it may break the build, because moc,rcc and uic binaries for wrong qt version may be used.
	# Setting QT_SELECT environment variable will enforce correct binaries (fix taken from vlc ebuild)
	export QT_SELECT=qt5
	
	git submodule init
	git submodule update
}

src_configure() {
	local mycmakeargs=(
		-DWITH_PARTITIONMANAGER=1
	)
	cmake-utils_src_configure
}
