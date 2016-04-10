# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

DESCRIPTION="A library providing Qt implementation of DBusMenu specification (meta mackage)"
HOMEPAGE="https://launchpad.net/libdbusmenu-qt/"
LICENSE="LGPL-2"
KEYWORDS="amd64 x86"
SLOT="0"
IUSE="debug doc +qt4 qt5"

REQUIRED_USE="|| ( qt4 qt5 )"

RDEPEND="
	qt4? ( ~dev-libs/libdbusmenu-qt4-${PV} )
	qt5? ( ~dev-libs/libdbusmenu-qt5-${PV} )
"
DEPEND=""
RESTRICT="test"
