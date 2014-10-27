# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils multilib toolchain-funcs versionator

MY_MAJORV=$(get_version_component_range 1-2)
MY_CLRV="4.0"

DESCRIPTION="GTK2 graphical frontend for LogMeIn Hamachi"
HOMEPAGE="http://haguichi.net"
SRC_URI="http://launchpad.net/${PN}/${MY_MAJORV}/${PV}/+download/${P}-clr${MY_CLRV}.tar.gz"

LICENSE="LGPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"
IUSE="debug"

DEPEND="net-misc/logmein-hamachi
	=dev-dotnet/gtk-sharp-2*
	=dev-dotnet/gconf-sharp-2*
	>=dev-dotnet/notify-sharp-0.4.0_pre20090305
	>=dev-dotnet/ndesk-dbus-glib-0.4.0"
RDEPEND="${DEPEND}"

S="${WORKDIR}/"${PN}"-${PV}"

src_configure() {
	econf \
		--prefix=/usr/ \
		$(use_enable debug ) \
		$(use_enable release )
}

src_compile() {
        emake \
                "CFLAGS=${CFLAGS}" \
                "LIBDIR=$(get_libdir)" \
                || die "Make failed"
}

src_install() {
	emake DESTDIR="${D}" install || die "Installation failed"
}
