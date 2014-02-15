# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="A GTK+ front-end for the SopCast P2P TV player."
HOMEPAGE="http://www.sopcast.com/"
SRC_URI="https://sopcast-player.googlecode.com/files/sopcast-player-0.8.5.tar.gz"

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="dev-util/debhelper
		sys-devel/gettext
		dev-lang/python
		dev-python/pygtk
		dev-python/pygobject
		dev-python/setuptools
		dev-util/desktop-file-utils
		x11-themes/hicolor-icon-theme
		dev-util/wxglade
		dev-python/pygtk
		dev-python/pyglet
		dev-python/pyvlc
		sys-libs/libstdc++-v3
		virtual/libstdc++
		media-video/vlc"
RDEPEND="${DEPEND}"

S=${WORKDIR}/${MY_P}

src_install() {
	exeinto /opt/${PN}
	newexe sopcast-player ${PN} || die "newexe failed"
	dosym /opt/${PN}/${PN} /usr/bin/${PN}
	dodoc Readme || die "dodoc failed"
}
