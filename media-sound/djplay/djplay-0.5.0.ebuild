# Copyright 1999-2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils unpacker

DESCRIPTION="Djplay sound application"
HOMEPAGE="http://djplay.sourceforge.net/"
SRC_URI="http://http.us.debian.org/debian/pool/main/d/${PN}/${PN}_${PV}-3.1+b1_amd64.deb"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="x11-libs/qt-meta:3"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_unpack() {
	unpack "${A}"
}

src_prepare() {
	unpack_deb http://http.us.debian.org/debian/pool/main/d/${PN}/${PN}_${PV}-3.1+b1_amd64.deb
}

src_install() {
	insinto /
	doins -r "${S}"/usr
	fperms u+x /usr/bin/djplay*
}
