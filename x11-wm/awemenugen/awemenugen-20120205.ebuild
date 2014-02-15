# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

inherit eutils

DESCRIPTION="X11 WM Menu"
HOMEPAGE=""
SRC_URI="mirror://sourceforge/project/${PN}/${P}.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND=""

S="${WORKDIR}/${PN}"

src_install() {
	cd "${S}" || die
	insinto /opt/${PN}/ || die
	doins "${S}"/${PN}.sh || die
	fperms 755 ${PN}.sh || die
	doins "${S}"/${PN}.jar || die
	fperms 644 ${PN}.jar || die

	insinto /opt/${PN}/lib/ || die
	doins "${S}"/lib/freemarker.jar || die
	fperms 644 lib/freemarker.jar || die

	insinto /usr/bin/ || die
	newbin "${S}"/awemenugen.sh awemenugen || die
}
