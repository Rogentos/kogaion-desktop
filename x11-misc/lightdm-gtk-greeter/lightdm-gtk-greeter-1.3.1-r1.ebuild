# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

DESCRIPTION="LightDM GTK+ Greeter"
HOMEPAGE="http://launchpad.net/lightdm-gtk-greeter"
SRC_URI="http://launchpad.net/lightdm-gtk-greeter/1.4/${PV}/+download/${P}.tar.gz"

LICENSE="GPL-3 LGPL-3"
SLOT="0"
KEYWORDS="amd64 arm ~ppc x86"
IUSE=""

# This ebuild needs custom Rogentos themes, thus it must depend on rogentos-artwork-core
DEPEND="x11-libs/gtk+:3
	>=x11-misc/lightdm-1.2.2"
RDEPEND="app-admin/eselect-lightdm
	x11-libs/gtk+:3
	>=x11-misc/lightdm-1.2.2
	x11-themes/kogaion-dark-theme
	x11-themes/faenza-kupertino-icons
	x11-themes/rogentos-artwork-core"

src_prepare() {
	# Apply custom Rogentos theme
	sed -i \
		-e 's:#logo=.*:logo=/usr/share/icons/Faenza-Kupertino-Dark/places/48/distributor-logo-rogentos.png:' \
		-e 's:#background=.*:background=/usr/share/backgrounds/kgdm.png:' \
		-e 's:#theme-name=.*:theme-name=Kogaion-dark:' \
		-e 's:#icon-theme-name=.*:icon-theme-name=Faenza-Kupertino-Dark:' \
		-e 's:#font-name=.*:font-name=Bitstream Vera Sans Roman:' \
		-e 's:#show-language-selector=.*:show-language-selector=true:' \
		-e 's:#xft-hintstyle=.*:xft-hintstyle=hintfull:' \
		-e 's:#xft-antialias=.*:xft-antialias=true:' \
		-e 's:#xft-rgba=.*:xft-rgba=rgb:' "data/${PN}.conf" || die
}

pkg_postinst() {
	# Make sure to have a greeter properly configured
	eselect lightdm set lightdm-gtk-greeter --use-old
}

pkg_postrm() {
	eselect lightdm set 1  # hope some other greeter is installed
}

