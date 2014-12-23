# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit gnome2-utils

DESCRIPTION="Kogaion faenza icons"
HOMEPAGE="http://rogentos.ro"
SRC_URI="http://pkg.rogentos.ro/~rogentos/distro/${CATEGORY}/${PN}/${P}.tar.gz
	http://buildserver.rogentos.ro/~kogaion/distro/${CATEGORY}/${PN}/${P}.tar.gz"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE=""

RDEPEND="x11-themes/faenza-icon-theme"

DEPEND=""

DEST="/usr/share/icons"
S="${WORKDIR}"

src_install() {
	insinto ${DEST}
	doins -r "${S}"/Faenza-Kupertino-Light
	doins -r "${S}"/Faenza-Kupertino-Dark
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
