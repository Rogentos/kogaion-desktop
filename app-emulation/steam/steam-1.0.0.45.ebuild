EAPI=5

inherit eutils

DESCRIPTION="Digital distribution client bootstrap package"
HOMEPAGE="http://steampowered.com/"
SRC_URI="http://repo.steampowered.com/${PN}/pool/${PN}/s/${PN}/${PN}_${PV}.tar.gz"

LICENSE="custom"
SLOT="0"
KEYWORDS="amd64 x86"

EMUL_X86_VER=20120520

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
					>=app-emulation/emul-linux-x86-xlibs-${EMUL_X86_VER}
					>=app-emulation/emul-linux-x86-soundlibs-${EMUL_X86_VER}
					>=app-emulation/emul-linux-x86-opengl-${EMUL_X86_VER}
		)
		x86?	(
					media-libs/alsa-lib
					media-libs/mesa
					x11-libs/libX11
		)"

S=${WORKDIR}/${PN}

src_install() {
	emake DESTDIR="${D}" install || die "make install failed"
	rm -rf "${D}"/usr/bin/steamdeps || die # we don't use apt-get
	dosym /bin/true /usr/bin/steamdeps || die # create blank steamdeps
}
