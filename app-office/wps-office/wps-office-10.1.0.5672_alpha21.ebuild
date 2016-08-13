# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=6
inherit eutils fdo-mime gnome2-utils unpacker versionator

MY_PV="$(get_version_component_range 1-4)"
MY_V="$(get_version_component_range 5)"

if [ -z "$(get_version_component_range 6)" ]; then
	MY_SP=""
else
	MY_SP="$(get_version_component_range 6)"
fi

case ${PV} in
	*_alpha*)
		MY_BRANCH=${MY_V/alpha/a}
		;;
	*_beta*)
		MY_BRANCH=${MY_V/beta/b}
		;;
	*)
		die "Invalid value for \${PV}: ${PV}"
		;;
esac
MY_VV=${MY_PV}~${MY_BRANCH}${MY_SP}

DESCRIPTION="WPS Office is an office productivity suite"
HOMEPAGE="http://linux.wps.cn/ http://wps-community.org/"
KEYWORDS="~amd64"
SRC_URI="http://kdl.cc.ksosoft.com/wps-community/download/${MY_BRANCH}/${PN}_${MY_VV}_x86_64.tar.xz"

SLOT="0"
RESTRICT="strip mirror" # mirror as explained at bug #547372
LICENSE="WPS-EULA"
IUSE=""

NATIVE_DEPEND="
	app-arch/bzip2
	dev-libs/expat
	dev-libs/glib:2
	dev-libs/libffi
	dev-libs/libxml2:2
	media-libs/fontconfig:1.0
	media-libs/freetype:2
	media-libs/glu
	media-libs/libpng:1.2
	virtual/opengl
	media-libs/tiff:3
	sys-apps/util-linux
	sys-libs/zlib
	x11-libs/libdrm
	x11-libs/libICE
	x11-libs/libSM
	x11-libs/libX11
	x11-libs/libXau
	x11-libs/libxcb
	x11-libs/libXdamage
	x11-libs/libXdmcp
	x11-libs/libXext
	x11-libs/libXfixes
	x11-libs/libXrender
	x11-libs/libXxf86vm
	media-libs/libmng
	net-print/cups
"
RDEPEND="
	${UNBUNDLED_LIBS}
	${NATIVE_DEPEND}
	net-nds/openldap
	dev-db/sqlite:3
"
DEPEND=""

S="${WORKDIR}/${PN}_${MY_VV}_x86_64"

src_install() {
	dodir /opt/kingsoft/wps-office
	insinto /opt/kingsoft/wps-office
	doins -r "${S}"/*
	fperms 0755 /opt/kingsoft/wps-office/office6/{wps,wpp,et}
	fperms 0755 /opt/kingsoft/wps-office/{wps,wpp,et}
	dodir /usr/bin
	for i in wps wpp et ; do
		dosym /opt/kingsoft/wps-office/$i /usr/bin/$i
	done
	dodir /usr/share/applications
	for i in wps-office-wps.desktop wps-office-wpp.desktop wps-office-et.desktop ; do
		dosym /opt/kingsoft/wps-office/resource/applications/$i /usr/share/applications/$i
	done
	dodir /usr/share/mime/packages
	for i in wps-office-wps.xml wps-office-wpp.xml wps-office-et.xml ; do
		dosym /opt/kingsoft/wps-office/resource/mime/packages/$i /usr/share/mime/packages/$i
	done
}

pkg_postinst() {
	fdo-mime_desktop_database_update
	fdo-mime_mime_database_update
	gnome2_icon_cache_update
}

pkg_postrm() {
	fdo-mime_desktop_database_update
	gnome2_icon_cache_update
}
