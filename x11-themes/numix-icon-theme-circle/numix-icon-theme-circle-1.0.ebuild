# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit gnome2-utils

DESCRIPTION="Numix Circle icon theme"
HOMEPAGE="https://numixproject.org"
SRC_URI="http://pkg.rogentos.ro/~rogentos/distro/${CATEGORY}/${PN}/"${PN}"-${PV}.tar.gz
		mirror://kogaion/${CATEGORY}/"${PN}"/${P}.tar.gz"

LICENSE="GPL-3.0+"
SLOT="0"
KEYWORDS="amd64 x86"

DEPEND="x11-themes/numix-icon-theme"
RDEPEND="${DEPEND}"

S="${WORKDIR}"/"${P}"

src_install() {
	insinto /usr/share/icons
	doins -r Numix-Circle Numix-Circle-Light
}

pkg_preinst() {
	gnome2_icon_savelist
}

pkg_postinst() {
	gnome2_icon_cache_update
}

pkg_postrm() {
	gnome2_icon_cache_update
}
