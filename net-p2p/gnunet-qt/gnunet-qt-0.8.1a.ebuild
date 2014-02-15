# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="2"

inherit eutils multilib qt4-r2

DESCRIPTION="QT Graphical front end for GNUnet."
HOMEPAGE="http://www.gnunet.org/"
SRC_URI="http://gnunet.org/download/${P}.tar.gz"

LICENSE="|| ( GPL-2 GPL-3 )"
SLOT="0"
KEYWORDS="~alpha ~amd64 ~hppa ~ia64 ~ppc ~ppc64 ~sparc ~x86 ~x86-fbsd"
IUSE=""

RDEPEND="x11-libs/qt-gui:4
	>=net-p2p/gnunet-${PV}"
DEPEND="${RDEPEND}"

src_configure() {
	econf --with-gnunet=/usr || die "econf failed"
	emake || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "emake install failed"
}
