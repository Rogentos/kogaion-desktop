# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Mediterranean-Night series 2.03 themes for Gnome 3.6.x and 3.8.x"
HOMEPAGE="http://gnome-look.org/content/show.php/MediterraneanNight+Series?content=156782"
SRC_URI="http://pkg.rogentos.ro/~rogentos/distro/${CATEGORY}/${PN}/${PN}-${PV}.tar.gz"
	#http://pkg2.rogentos.ro/~noxis/distro/${CATEGORY}/${PN}/${PN}-${PV}.tar.gz (temporary disabled)
LICENSE="GPL"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE=""

RDEPEND="x11-themes/gtk-engines-murrine
	x11-themes/gtk-engines"

DEPEND=""

DEST="/usr/share/themes"
S="${WORKDIR}"

src_install() {
	insinto ${DEST} || die
	doins -r "${S}"/MediterraneanDark || die
	doins -r "${S}"/MediterraneanDarkest || die
	doins -r "${S}"/MediterraneanGrayDark || die
	doins -r "${S}"/MediterraneanLight || die
	doins -r "${S}"/MediterraneanLightDarkest || die
	doins -r "${S}"/MediterraneanNight || die
	doins -r "${S}"/MediterraneanNightDarkest || die
	doins -r "${S}"/MediterraneanTribute || die
	doins -r "${S}"/MediterraneanTributeBlue || die
	doins -r "${S}"/MediterraneanTributeDark || die
	doins -r "${S}"/MediterraneanWhite || die
	doins -r "${S}"/MediterraneanWhiteNight || die
}
