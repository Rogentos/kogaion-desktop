# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="Kogaion dark GTK/XFWM theme"
HOMEPAGE="https://github.com/bionel/kogaion-src"
SRC_URI="https://pk2.rogentos.ro/~rogentos/${CATEGORY}/${PN}/${PN}-${PVR}.tar.gz
	http://pkg.rogentos.ro/~noxis/${CATEGORY}/${PN}/${PN}-${PVR}.tar.gz"

LICENSE="GPL"
SLOT="0"
KEYWORDS="~arm ~amd64 ~x86"
IUSE="gtk3 gtk2 gnome-shell unity cinnamon xfwm4"

RDEPEND="gtk3? ( x11-themes/gtk-engines-unico )
	x11-themes/gtk-engines-equinox
	x11-themes/gtk-engines
	x11-themes/kogaion-elementary-icons"
DEPEND=""

Z="Kogaion-dark"
S="${WORKDIR}"/${Z}/
THEME="/usr/share/themes"

src_install() {
	dodir ${THEME}/${Z} || die
	insinto ${THEME}/${Z} || die
	doins "${S}"/index.theme || die

	if use gtk3; then
		doins -r "${S}"/gtk-3.0 || die "Cannot copy gtk3"
	else
	ewarn "Gtk3 Files weren't copied"
	fi

	if use gtk2; then
		doins -r "${S}"/gtk-2.0 || die "Cannot copy gtk2"
		doins -r "${S}"/metacity-1 || die "Cannot copy metacity-1"
	else
	ewarn "Gtk2 Files were not copied"
	fi

	if use gnome-shell; then
		doins -r "${S}"/gnome-shell || die "Cannot copy gnome-shell"
	else
	ewarn "Gnome-shell Files were not copied"
	fi

	if use cinnamon; then
		doins -r "${S}"/cinnamon || die "Cannot copy cinnamon"
	else
	ewarn "Cinnamon Files were not copied"
	fi

	if use unity; then
		doins -r "${S}"/unity || die "Cannot copy unity"
	else
	ewarn "Unity Files were not copied"
	fi

	if use xfwm4; then
		doins -r "${S}"/xfwm4 || die "Cannot copy xfwm"
	else
	ewarn "Xfwm Files were not copied"
        fi
}
