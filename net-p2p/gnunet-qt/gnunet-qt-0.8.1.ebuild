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

#	cd "${S}"/Qt${myqtver}
#	eqmake${myqtver} qscintilla.pro
#
#	cd "${S}"/designer-Qt${myqtver}
#	eqmake${myqtver} designer.pro
#}

#src_compile() {
#	cd "${S}"/Qt${myqtver}
#	emake all staticlib || die "emake failed"
#
#	cd "${S}"/designer-Qt${myqtver}
#	emake || die "failed to build designer plugin"
#}

#src_install() {
#	emake INSTALL_ROOT="${D}" install || die "designer plugin installation failed"
#	dodoc ChangeLog NEWS
#}
