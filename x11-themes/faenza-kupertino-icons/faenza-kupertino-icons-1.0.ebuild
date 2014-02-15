# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
inherit gnome2-utils

DESCRIPTION="Kogaion faenza icons"
HOMEPAGE="http://rogentos.ro"
SRC_URI="http://pkg.rogentos.ro/~rogentos/distro/${CATEGORY}/${PN}/${PN}-${PV}.tar.gz
	http://pkg2.rogentos.ro/~noxis/distro/${CATEGORY}/${PN}/${PN}-${PV}.tar.gz"
LICENSE="GPL"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE=""

RDEPEND="x11-themes/faenza-icon-theme"

DEPEND=""

DEST="/usr/share/icons"
S="${WORKDIR}"

src_install() {
	insinto ${DEST} || die
	doins -r "${S}"/Faenza-Kupertino-Light || die
	doins -r "${S}"/Faenza-Kupertino-Dark || die
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
