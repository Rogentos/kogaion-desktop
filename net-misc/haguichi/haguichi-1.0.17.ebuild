# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit eutils multilib toolchain-funcs

DESCRIPTION="Lunduke made Linux Tycoon"
HOMEPAGE="http://lunduke.com/?page_id=2646"
SRC_URI="http://launchpad.net/haguichi/1.0/1.0.17/+download/${PN}-${PV}-clr4.0.tar.gz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="-* ~amd64 ~x86"

RDEPEND="x11-libs/pango
	dev-dotnet/gtk-sharp
	dev-dotnet/notify-sharp
	dev-dotnet/gconf-sharp
	dev-dotnet/ndesk-dbus
	dev-dotnet/ndesk-dbus-glib
        x11-libs/pixman
        amd64? (
                app-emulation/emul-linux-x86-gtklibs
                app-emulation/emul-linux-x86-baselibs   )"
DEPEND=""

S="${WORKDIR}/${PN}-${PV}"

src_compile() {
	#cd "{S}" || die
        emake \
                DEBUG="" \
                "CFLAGS=${CFLAGS}" \
                "LIBDIR=$(get_libdir)" \
                || die "emake failed"
}

src_install() {
	cd /usr/lib64/
	dodir ${PN} || die
	doins "${S}"/bin/Release/haguichi || die
        doins "${S}"/bin/Release/Haguichi.exe || die

	cd /usr/share/icons || die
	doins "${S}"/bin/Release/icons/* || die

	cd /usr/share/applications || die
	doins "${S}"/bin/Release/applications/Haguichi || die
}
