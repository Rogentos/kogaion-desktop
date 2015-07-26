# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5
PYTHON_COMPAT=( python3_3 )

inherit eutils cmake-utils python-r1

SRC_URI="https://github.com/calamares/calamares/releases/download/v1.1/calamares-1.1.tar.gz"

DESCRIPTION="Distribution-independent installer framework"
HOMEPAGE="http://calamares.io"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+python"

S="${WORKDIR}/${PN}-${PV}"

DEPEND="
	dev-vcs/git
	python? (
		>=dev-lang/python-3.3.5-r1:3.3
		>=dev-libs/boost-1.55.0-r2[python_targets_python3_3]
	)
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

RDEPEND=">=app-misc/calamares-runtime-2.0[branding]"

src_prepare() {
	# replace calamares installer desktop icon
	sed -i "s/Icon=calamares/Icon=start-here/g" "${S}/calamares.desktop"
	# If qtchooser is installed, it may break the build, because moc,rcc and uic binaries for wrong qt version may be used.
	# Setting QT_SELECT environment variable will enforce correct binaries (fix taken from vlc ebuild)
	export QT_SELECT=qt5
}

src_configure() {
	local mycmakeargs=(
		-DWITH_PARTITIONMANAGER=1
	)
	cmake-utils_src_configure
}
