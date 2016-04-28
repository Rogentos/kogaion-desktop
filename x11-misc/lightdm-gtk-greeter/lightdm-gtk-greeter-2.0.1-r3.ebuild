# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=4

inherit versionator

DESCRIPTION="LightDM GTK+ Greeter"
HOMEPAGE="https://launchpad.net/lightdm-gtk-greeter"
SRC_URI="https://launchpad.net/lightdm-gtk-greeter/$(get_version_component_range 1-2)/${PV}/+download/${P}.tar.gz branding? (
https://dev.gentoo.org/~hwoarang/distfiles/lightdm-gentoo-patch-2.tar.gz )"

LICENSE="GPL-3 LGPL-3
	branding? ( CC-BY-3.0 )"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="ayatana +branding"

COMMON_DEPEND="ayatana? ( dev-libs/libindicator:3 )
	branding? ( >=x11-themes/kogaion-artwork-core-3 )
	x11-libs/gtk+:3
	>=x11-misc/lightdm-1.2.2"

DEPEND="${COMMON_DEPEND}
	sys-devel/gettext"

RDEPEND="${COMMON_DEPEND}
	x11-themes/gnome-themes-standard
	|| ( >=x11-themes/adwaita-icon-theme-3.14.1 x11-themes/gnome-icon-theme )"


src_prepare() {
	if use branding; then
		epatch "${FILESDIR}/${PN}-kogaion.patch"
	fi
}

src_configure() {
	econf --enable-kill-on-sigterm \
		$(use_enable ayatana libindicator)
}

src_install() {
	default
}
