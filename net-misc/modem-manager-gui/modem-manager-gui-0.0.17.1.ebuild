# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils

DESCRIPTION="Frontend for ModemManager daemon able to control specific modem functions"
HOMEPAGE="http://linuxonly.ru/cms/page.php?"
SRC_URI="http://download.tuxfamily.org/gsf/source/${PN}-${PV}.tar.gz"

LICENSE="GPL-3"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE="+networkmanager +ofono -connman"

RDEPEND="
	sys-libs/gdbm
	x11-libs/gtk+:3
	x11-libs/libnotify
	net-misc/modemmanager
	ofono? ( net-misc/ofono )
	networkmanager? ( net-misc/networkmanager )
	connman? ( net-misc/connman )"
DEPEND="
	app-text/po4a
	dev-util/itstool
	"

S="${WORKDIR}/${PN}-${PV}"

src_configure() {
	econf
}

src_compile() {
	emake || die "compilation failed"
}

src_install() {
	default
}
