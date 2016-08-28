# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit qmake-utils

DESCRIPTION="YouTube Browser for SMPlayer"
HOMEPAGE="http://smplayer.sourceforge.net/smtube"
SRC_URI="mirror://sourceforge/smplayer/${P}.tar.bz2"
KEYWORDS="amd64 x86"
LICENSE="GPL-2+"
SLOT="0"
IUSE="qt5"

# Deps in makefile seemed to be -core, -network, -script, -gui, -webkit, but the
# given packages seem to be deprecated...
DEPEND="qt5? ( dev-qt/qtcore:5 dev-qt/qtgui:5 dev-qt/qtwebkit:5 dev-qt/qtscript:5 )
		!qt5? ( dev-qt/qtcore:4 dev-qt/qtgui:4 dev-qt/qtwebkit:4 dev-qt/qtscript:4 )"
RDEPEND="${DEPEND}
	|| ( media-video/smplayer[streaming] media-video/mpv media-video/mplayer media-video/vlc media-video/totem media-video/gnome-mplayer )"

src_compile() {
	if use qt5; then
		eqmake5 src/${PN}.pro
	else
		eqmake4 src/${PN}.pro
	fi
	emake
}

src_install() {
	dobin ${PN}
	domenu ${PN}.desktop
	newicon icons/${PN}_64.png ${PN}.png
	dodoc Changelog
}
