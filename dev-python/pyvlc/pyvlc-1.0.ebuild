# Copyright 1999-2009 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit git-2

DESCRIPTION="Python binding to VLC library"
HOMEPAGE="http://wiki.videolan.org/Python_bindings"
EGIT_REPO_URI="git://git.videolan.org/vlc/bindings/python.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS=""
IUSE="generated examples wxwidgets qt4 gtk"

DEPEND="media-video/vlc"
RDEPEND="${DEPEND}
	examples? ( dev-python/pygtk )"
DOCS="README"

S="${WORKDIR}"/${PN}-${PV}

src_compile() {
	cd "${EGIT_STORE_DIR}"
	cd "${S}"
}

src_install() {
	cd "${S}"
	
	if use examples ; then
	cd "${S}"/examples
	ls -la
		if use wxwidgets ; then
			dodoc wxvlc.py
		fi
		if use qt4 ; then
			dodoc qtvlc.py
		fi
		if use gtk ; then
			dodoc gtkvlc.py
		fi
	fi
	if use generated ; then
		insinto "${S}"/generated
		dodoc vlc.py
	fi
}
