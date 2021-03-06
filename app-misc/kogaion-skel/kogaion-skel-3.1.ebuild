# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
EGIT_REPO_URI="https://gitlab.com/kogaion/kogaion-skel.git"

inherit eutils git-2 fdo-mime

DESCRIPTION="Kogaion Linux skel tree"
HOMEPAGE="http://www.rogentos.ro/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="amd64 ~arm x86"
IUSE=""
DEPEND=""
RDEPEND="
	x11-themes/kogaion-theme
	x11-themes/numix-icon-theme
	x11-themes/numix-icon-theme-circle
	x11-themes/kogaion-artwork-community
	x11-themes/kogaion-artwork-core"

src_install () {
	dodir /etc/xdg/menus
	cp "${S}"/* "${D}"/etc/ -Ra
	chown root:root "${D}"/etc/skel -R

	dodir /usr/share/desktop-directories
	cp "${FILESDIR}"/3.0/xdg/*.directory "${D}"/usr/share/desktop-directories/
	dodir /usr/share/kogaion
	cp -a "${FILESDIR}"/3.0/* "${D}"/usr/share/kogaion/
	doicon "${FILESDIR}"/3.0/img/kogaion-weblink.png
}

pkg_postinst() {
	if [ -x "/usr/bin/xdg-desktop-menu" ]; then
		xdg-desktop-menu install \
			/usr/share/kogaion/xdg/kogaion-kogaion.directory \
			/usr/share/kogaion/xdg/*.desktop
	fi

	fdo-mime_desktop_database_update
}

pkg_prerm() {
	if [ -x "/usr/bin/xdg-desktop-menu" ]; then
		xdg-desktop-menu uninstall /usr/share/kogaion/xdg/kogaion-kogaion.directory /usr/share/kogaion/xdg/*.desktop
	fi
}
