# Copyright 1999-2011 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Pacifica icon theme"
HOMEPAGE=""
SRC_URI="http://fc07.deviantart.net/fs71/f/2013/267/b/a/pacifica_by_bokehlicia-d6nn5lb.zip"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"
IUSE=""

DEPEND=""
RDEPEND=""

S="${WORKDIR}"

src_install() {
	dodir /usr/share/icons/ || die
	insinto /usr/share/icons || die
	doins -r "${S}"/Pacifica || die
}
