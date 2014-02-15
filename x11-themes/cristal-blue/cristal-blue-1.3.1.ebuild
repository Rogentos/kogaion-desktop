# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

DESCRIPTION="Cristal-Blue Rogentos theme"
HOMEPAGE="http://rogentos.ro"
SRC_URI="http://pkg2.rogentos.ro/~noxis/distro/${CATEGORY}/${PN}-${PV}.tar.gz
	http://pkg.rogentos.ro/~rogentos/distro/${CATEGORY}/${PN}-${PV}.tar.gz
	emerald? ( http://pkg2.rogentos.ro/~noxis/distro/${CATEGORY}/cristal-oxigen-${PV}.emerald )
	cursor? ( http://pkg3.rogentos.ro/~noxis/distro/${CATEGORY}/cristal-cursor.gz ) "

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="gtk2 cursor emerald"

RDEPEND="gtk2? ( x11-themes/gtk-engines-unico )
	>=x11-themes/gtk-engines-murrine-0.98.1.1
	x11-themes/gtk-engines"
DEPEND=""

Z="cristal-blue"
S="${WORKDIR}"/${Z}/
THEME="/usr/share/themes"

src_unpack() {
	if use emerald; then
		unpack ${A}
	fi
}

src_install() {
	dodir ${THEME}/${Z} || die
	insinto ${THEME}/${Z} || die
	doins "${S}"/index.theme || die

	if use gtk2; then
		doins -r "${S}"/gtk-3.0 || die "Cannot copy gtk2"
	fi
	if use emerald; then
		cd "${S}"
		doins cristal-oxigen-1.3.1.emerald $THEME
	fi
	if use cursor; then
		if [ -f "/usr/share/cursors/xorg-x11" ]; then
			cd /usr/share/cursors/xorg-x11
			doins "${S}"/cristal-cursor
		else
			ewarn "There is no such folder as xorg-x11
			       Create it yourself!"
		fi
	fi
}
