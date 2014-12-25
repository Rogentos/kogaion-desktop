# Copyright 1999-2014 Sabayon Linux
# Copyright 2014 Kogaion
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4
EGIT_REPO_URI="git://github.com/Rogentos/roskel.git"

inherit eutils git-2 fdo-mime

DESCRIPTION="Kogaion Linux skel tree"
HOMEPAGE="http://www.rogentos.ro/"
LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""
RDEPEND=""
DEPEND="!>=app-misc/rogentos-skel-1
	!app-misc/sabayon-skel"

src_install () {
	dodir /etc/xdg/menus
	cp "${S}"/* "${D}"/etc/ -Ra
	chown root:root "${D}"/etc/skel -R

	dodir /usr/share/desktop-directories
	cp "${FILESDIR}"/3.0/xdg/*.directory "${D}"/usr/share/desktop-directories/
	dodir /usr/share/kogaion
	cp -a "${FILESDIR}"/3.0/* "${D}"/usr/share/kogaion/
	doicon "${FILESDIR}"/3.0/img/kogaion-weblink.png

	insinto /etc/bash/ || die "Failed to insinto"
	doins "${S}"/skel/.bash/bashrc /etc/bash/ || die "Cannot copy bashrc"
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
		xdg-desktop-menu uninstall /usr/share/kogaion/xdg/kogaion-argetn.directory /usr/share/kogaion/xdg/*.desktop
	fi
}
