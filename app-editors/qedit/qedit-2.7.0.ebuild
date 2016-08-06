# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/x11-terms/qterminal/qterminal-0.6.0.ebuild,v 1.1 2015/02/03 09:05:04 yngwin Exp $

EAPI=5
inherit cmake-utils

DESCRIPTION="Qt-based multitab text editor"
HOMEPAGE="http://hugo.pereira.free.fr/software/index.php?page=package&package_list=software_list_qt4&package=qedit&full=0"
SRC_URI="http://hugo.pereira.free.fr/software/tgz/${P}.tar.gz"

LICENSE="GPL-2+"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="debug qt4 qt5"

REQUIRED_USE="^^ ( qt4 qt5 )"

DEPEND="
	qt4? (
		dev-qt/qtcore:4
		dev-qt/qtgui:4
		dev-qt/qtwidgets:4
		dev-qt/qtxml:4
	)
	qt5? (
		dev-qt/qtcore:5
		dev-qt/qtgui:5
		dev-qt/qtprintsupport:5
		dev-qt/qtwidgets:5
		dev-qt/qtxml:5
	)"
RDEPEND="${DEPEND}"

src_configure() {
	local mycmakeargs=(
		$(cmake-utils_use_use qt5)
		$(cmake-utils_use_use qt4 SYSTEM_QXT)
	)
	cmake-utils_src_configure
}
