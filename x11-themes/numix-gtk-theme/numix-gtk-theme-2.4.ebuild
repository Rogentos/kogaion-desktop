# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

MY_PN="Numix"

DESCRIPTION="Numix GTK Theme"
HOMEPAGE="https://numixproject.org/"
SRC_URI="https://launchpad.net/~numix/+archive/ubuntu/ppa/+files/${PN}_${PV}.orig.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="+gtk3 metacity openbox unity xfwm4"

DEPEND=""
RDEPEND="x11-themes/gtk-engines-murrine
	gtk3? ( x11-themes/gtk-engines-unico )"

S="${WORKDIR}/${PN}-${PV}"

src_install() {
	cd "${S}"
	dodir /usr/share/themes/${MY_PN}
	insinto /usr/share/themes/${MY_PN}
	doins -r "${S}"/*
	
	use gtk3 || {
		rm -R "${D}"/usr/share/themes/*/gtk-3.0 || die
	}
	
	use metacity || {
		rm -R "${D}"/usr/share/themes/*/metacity-1 || die
	}
	
	use openbox || {
		rm -R "${D}"/usr/share/themes/*/openbox-3 || die
	}
	
	use unity || {
		rm -R "${D}"/usr/share/themes/*/unity || die
	}
	
	use xfwm4 || {
		rm -R "${D}"/usr/share/themes/*/xfwm4 || die
	}
}
