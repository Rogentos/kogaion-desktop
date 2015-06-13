# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/sys-auth/polkit-qt/polkit-qt-0.112.0-r1.ebuild,v 1.6 2015/05/16 10:14:07 jer Exp $

EAPI=5

MY_P="${P/qt/qt-1}"

DESCRIPTION="PolicyKit Qt API wrapper library (meta package)"
HOMEPAGE="http://www.kde.org/"
SRC_URI=""

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm ~arm64 ppc ppc64 x86 ~x86-fbsd"
IUSE="debug examples +qt4 qt5"

REQUIRED_USE="|| ( qt4 qt5 )"

RDEPEND="
	qt4? ( ~sys-auth/polkit-qt4-${PV} )
	qt5? ( ~sys-auth/polkit-qt5-${PV} )
"
DEPEND=""

# bug #529686
RESTRICT="test"
