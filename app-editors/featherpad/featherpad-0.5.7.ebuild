# Copyright 1999-2016 Gentoo Foundation 
# Distributed under the terms of the GNU General Public License v2 

EAPI=5
inherit eutils qmake-utils git-r3

DESCRIPTION="Lightweight Qt5 Plain-Text Editor for Linux"
EGIT_REPO_URI="https://github.com/tsujan/FeatherPad.git"
EGIT_COMMIT="c7f62469af0222a3cedefbb39278e4f80077dcfb"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE=""

RDEPEND=" 
      dev-qt/qtcore:5 
      dev-qt/qtgui:5  
      dev-qt/qtwidgets:5  
      dev-qt/qtsvg:5 
"
DEPEND="${RDEPEND}"

src_configure() { 
   eqmake5 PREFIX="${EPREFIX}/usr"  fp.pro 
}

src_install() { 
   make INSTALL_ROOT=${D} install || die 
}
