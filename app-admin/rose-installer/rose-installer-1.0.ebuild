# Copyright 1999-2010 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=5

inherit eutils git-2

DESCRIPTION="RogentOS GUI Installer for Servers"
HOMEPAGE="http://github.com/GabiBGS"
EGIT_REPO_URI="https://github.com/Rogentos/chroot_deploy.git"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="app-misc/rogentos-skel
	dev-lang/python:2.7
	dev-python/PyQt4"
RDEPEND="${DEPEND}"

S="${WORKDIR}"

src_install() {
	insinto /opt/RoSeInstaller
	doins "${S}"/RoSeInstaller*
	doins "${FILESDIR}"/${PN}.png

	dodir /usr/bin/
	cat > "${D}"/usr/bin/RoSeInstaller <<-EOF
	/usr/bin/python2.7 /opt/RoSeInstaller/RoSeInstaller.py
EOF

	insinto /usr/share/applications/
	doins "${FILESDIR}"/RoSeInstaller.desktop

	fperms 755 /usr/bin/RoSeInstaller
	
	insinto /etc/skel/Desktop
	doins "${FILESDIR}"/RoSeInstaller.desktop
}
