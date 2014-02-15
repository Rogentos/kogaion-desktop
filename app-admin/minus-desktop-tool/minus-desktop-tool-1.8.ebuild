# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="4"

inherit unpacker

DESCRIPTION="Super-useful stream editor (sed)"
HOMEPAGE="https://minus.com/pages/tools"
SRC_URI="http://blog.minus.com/updates/${PN}_${ARCH}.deb -> ${P}_${ARCH}.deb"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

RDEPEND=""
DEPEND="dev-libs/qt-core
        dev-libs/qjson"
