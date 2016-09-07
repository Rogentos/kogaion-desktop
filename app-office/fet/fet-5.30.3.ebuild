# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit eutils qmake-utils

DESCRIPTION="Opensource school/high-school/university timetable scheduling software"
HOMEPAGE="http://lalescu.ro/liviu/fet/"
SRC_URI="http://lalescu.ro/liviu/fet/download/fet-5.30.3.tar.bz2"

LICENSE="AGPL3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

DEPEND="dev-qt/qtgui:5
	dev-qt/qtnetwork:5
	dev-qt/qtprintsupport:5
	dev-qt/qtwidgets:5"
RDEPEND="${DEPEND}"

src_configure () {
	eqmake5 ${PN}.pro
}

src_install () {
	emake INSTALL_ROOT=${D} install || die
}
