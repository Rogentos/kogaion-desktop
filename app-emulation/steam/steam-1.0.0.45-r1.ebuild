# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2


EAPI=5

inherit eutils

DESCRIPTION="Digital distribution client bootstrap package"
HOMEPAGE="http://steampowered.com/"
SRC_URI="http://repo.steampowered.com/${PN}/pool/${PN}/s/${PN}/${PN}_${PV}.tar.gz"

LICENSE="custom"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
		virtual/ttf-fonts
		dev-util/desktop-file-utils
		x11-themes/hicolor-icon-theme
		net-misc/curl
		sys-apps/dbus
		media-libs/freetype
		x11-libs/gdk-pixbuf
		gnome-extra/zenity
		amd64?	(
					>=media-libs/alsa-lib-1.0.28[abi_x86_32(-)]
					>=media-libs/mesa-10.0.4[abi_x86_32(-)]
					>=x11-libs/libX11-1.6.2[abi_x86_32(-)]
		)
		x86?	(
					media-libs/alsa-lib
					media-libs/mesa
					x11-libs/libX11
		)"

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	rm -rf "${D}"/usr/bin/steamdeps || die
	dosym /bin/true /usr/bin/steamdeps || die
}
