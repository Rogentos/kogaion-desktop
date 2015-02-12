# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

inherit eutils
DESCRIPTION="LogMeIn Hamachi VPN GUI Client"
HOMEPAGE="http://www.haguichi.net/"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"

RDEPEND="
dev-lang/mono
net-misc/logmein-hamachi
dev-dotnet/gtk-sharp
dev-dotnet/notify-sharp
dev-dotnet/gconf-sharp
dev-dotnet/ndesk-dbus
dev-dotnet/ndesk-dbus-glib
kde-base/dolphin
kde-base/konsole
kde-base/krdc
"
SRC_URI="http://launchpad.net/haguichi/1.0/1.0.13/+download/haguichi-1.0.13-clr4.0.tar.gz"
IUSE=""

src_compile() {
	econf || die "configure failed"
	emake || die "make failed"
}

src_test(){
	emake check || die
}

src_install(){
	emake DESTDIR="${D}" install || die "install failed"
	/etc/init.d/logmein-hamachi restart
}

