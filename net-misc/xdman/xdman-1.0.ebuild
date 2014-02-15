# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="XDman Internet Downloader"
HOMEPAGE="http://xdman.sourceforge.net/"
SRC_URI="mirror://sourceforge/${PN}/${PN}.zip"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-admin/eselect-java"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	ls $S
	dodir /usr/share/${PN}
	dodir /usr/share/applications/
	dodir /usr/share/pixmaps
	dodir /usr/bin/

	insinto /usr/share/${PN}
	doins "${S}"/${PN}.jar
	cd "${D}"/usr/share/${PN}
	echo "cd /usr/share/${PN} && \
	java -jar ${PN}.jar" > "${D}"/usr/bin/${PN}

	insinto /usr/share/pixmaps
	doins "${S}"/icon.png

	insinto /usr/share/${PN}
	make_desktop_entry xdman xdman \
		"/usr/share/${PN}/icon.png" \
		Internet

	fperms u+x /usr/bin/${PN}
}
