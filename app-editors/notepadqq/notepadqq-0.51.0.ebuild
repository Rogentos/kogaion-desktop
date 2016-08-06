# Copyright 1999-2016 Gentoo Foundation 
# Distributed under the terms of the GNU General Public License v2 
# $Header: /dev-util/notepadqq-9999.ebuild,v 0.1 frostwork $ 

EAPI=5
inherit qmake-utils git-r3

MY_PN=""

DESCRIPTION="Notepad++-like editor for Linux"
EGIT_REPO_URI="https://github.com/${PN}/${PN}.git"
EGIT_COMMIT="c4edf363ce12da2fb5ec707b7d6f6589d43bd5c9"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS=""
IUSE=""

RDEPEND=" 
      dev-qt/qtcore:5 
      dev-qt/qtdeclarative:5 
      dev-qt/qtgui:5 
      dev-qt/qtnetwork:5 
      dev-qt/qtscript:5 
      dev-qt/qtwidgets:5 
      dev-qt/qtwebkit:5 
      dev-qt/qtsvg:5 
"
DEPEND="${RDEPEND}"

src_configure() { 
   eqmake5 PREFIX="${EPREFIX}/usr"  ${PN}.pro 
}

src_install() { 
   make INSTALL_ROOT=${D} install || die 
}
