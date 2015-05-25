# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils versionator

MY_PV=$(get_version_component_range 1-2)
DESCRIPTION="Popular easy-to-use and secure password manager"
HOMEPAGE="http://sourceforge.net/projects/passwordsafe/"
SRC_URI="http://sourceforge.net/projects/passwordsafe/files/Linux-BETA/${MY_PV}/pwsafe-${MY_PV}BETA-src.tgz"

LICENSE="Artistic-2"
SLOT="0"
KEYWORDS="~x86"

DEPEND="
x11-libs/wxGTK
dev-libs/xerces-c
x11-libs/libXt
x11-libs/libXtst
"
RDEPEND="${DEPEND}"

S="${WORKDIR}/pwsafe-${MY_PV}BETA"

src_prepare() {
	# Address name collisions with app-misc/pwsafe.
	epatch "${FILESDIR}/${PN}-fix-file-collisions.patch"
}

src_compile() {
	# Alas, Password Safe is not an autotools project.
	emake release
	emake help
}

src_install() {
	# Aarrgghh. Makefile has no install target. Doing it manually.
	# This installation info is derived from the suplied Debian package build script.
	# Several new names are used to address name collisions with app-misc/pwsafe.

	newbin  src/ui/wxWidgets/GCCUnicodeRelease/pwsafe ${PN}
	insinto /usr/share/pwsafe/xml
	doins   xml/*
	# Debian package build script lists these but currently the makery doesn't seem to make them.
	# insinto /usr/share/locale
	# doins   src/ui/wxWidgets/I18N/mos/*

	dodoc   README.txt docs/{ReleaseNotes.txt,ChangeLog.txt}
	newman  docs/pwsafe.1 ${PN}.1

	# The upstream Makefile builds this .zip file from html source material for
	# use by the package's internal help system. Must prevent Portage from
	# applying additional compression.
	docompress -x /usr/share/doc/${PN}/help
	insinto /usr/share/doc/${PN}/help
	doins   help/help.zip

	newmenu install/desktop/pwsafe.desktop ${PN}.desktop
	newicon install/graphics/pwsafe.png    ${PN}.png
}
