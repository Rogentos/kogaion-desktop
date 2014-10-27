# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils

DESCRIPTION="Pymaxe is an easy to use and open-source application which lets you download music or videos from some media-sharing websites, such as YouTube, Trilulilu or 4shared"
HOMEPAGE="http://pymaxe.com"
SRC_URI="http://pymaxe.com/files/latest/${PN}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="media-video/mplayer2
	media-video/vlc
	virtual/ffmpeg
	dev-python/pygtk
	media-libs/gst-plugins-ugly
	media-plugins/gst-plugins-ffmpeg
	media-plugins/gst-plugins-meta"
DEPEND=""

S="${WORKDIR}"


src_install() {
	cd "${S}"
	doins -r "${S}"/usr || die
	fperms 755 /usr/bin/${PN} || die
}
