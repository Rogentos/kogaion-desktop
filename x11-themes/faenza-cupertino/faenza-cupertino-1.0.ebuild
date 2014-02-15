# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: Exp $

EAPI=4

inherit kde4-base

DESCRIPTION="Faenza Cupertino"
HOMEPAGE="http://tiheum.deviantart.com/"

MY_PN="Faenza"

SRC_URI="http://pkg.rogentos.ro/~rogentos/distro/x11-themes/${PN}/${MY_PN}.tar.gz
	http://pkg3.rogentos.ro/~noxis/distro/x11-themes/${PN}/${MY_PN}.tar.gz"

LICENSE="LGPL-3"
KEYWORDS="~amd64 ~x86 ~arm"
IUSE=""
SLOT="0"

DEPEND="${RDEPEND}"
RDEPEND="${DEPEND}"

S="${WORKDIR}/Faenza"

src_prepare() {
	insinto /usr/share/icons
}

src_install() {
	doins -r "${S}" || die
}
