# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Calamares distribution-independent installer framework runtime meta-package (containing all the runtime dependencies)"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+branding +python"

DEPEND=""
RDEPEND="
	python? (
		>=dev-lang/python-3.3.5-r1:3.3
		>=dev-libs/boost-1.55.0-r2[python_targets_python3_3]
	)
	branding? ( >=x11-themes/kogaion-artwork-calamares-2.0 )
	>=app-misc/calamares-config-kogaion-2.0
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
	sys-boot/os-prober
	sys-auth/polkit-qt5
	sys-fs/udisks:2[systemd]
	virtual/udev[systemd]"
