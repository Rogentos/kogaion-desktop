# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

inherit eutils autotools

MY_PV="${PV/_/}"

DESCRIPTION="GNUnet is an anonymous, distributed, reputation based network."
HOMEPAGE="http://gnunet.org/"
SRC_URI="http://ftp.gnu.org/gnu/gnunet/${PN}-${MY_PV}.tar.gz"
#tests don't work
RESTRICT="test"

IUSE="mysql nls sqlite"
KEYWORDS="~amd64 ~ppc ~ppc64 ~sparc ~x86"
LICENSE="GPL-2"
SLOT="0"
S="${WORKDIR}/${PN}-${MY_PV}"

DEPEND=">=dev-libs/libgcrypt-1.2.0
	>=media-libs/libextractor-0.6.1
	>=dev-libs/gmp-4.0.0
	sys-libs/zlib
	net-misc/curl
	sys-apps/sed
	mysql? ( >=virtual/mysql-4.0 )
        sqlite? ( >=dev-db/sqlite-3.0.8 )
	nls? ( sys-devel/gettext )
	>=net-libs/libmicrohttpd-0.4.6"

pkg_setup() {
	if ! use mysql && ! use sqlite; then
		einfo
		einfo "You need to specify at least one of 'mysql' or 'sqlite'"
		einfo "USE flag in order to have properly installed gnunet"
		einfo
		die "Invalid USE flag set"
	fi
}

pkg_preinst() {
	enewgroup gnunetd
	enewuser gnunetd -1 -1 /dev/null gnunetd
}

src_prepare() {
	sed -i 's:@GN_USER_HOME_DIR@:/etc:g' src/include/gnunet_directories.h.in
	AT_M4DIR="${S}/m4" eautoreconf
}

src_compile() {
	local myconf
	use mysql || myconf="${myconf} --without-mysql"
	econf \
		$(use_enable nls) \
		${myconf} || die "econf failed"
	emake -j1 || die "emake failed"
}

src_install() {
	emake DESTDIR="${D}" -j1 install || die "make install failed"
	dodoc AUTHORS ChangeLog INSTALL NEWS README
	docinto contrib
	dodoc contrib/*
	newinitd "${FILESDIR}"/${PN}.initd-0.9.0v2 gnunet
	dodir /var/lib/gnunet
	chown gnunetd:gnunetd "${D}"/var/lib/gnunet
}

pkg_postinst() {
	# make sure permissions are ok
	chown -R gnunetd:gnunetd "${ROOT}"/var/lib/gnunet

	ewarn "This ebuild is HIGLY experimental"
}
