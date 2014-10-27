# Copyright 2004-2013 RogentOS
# Distributed under the terms of the GNU General Public License v2

EAPI=5

EGIT_REPO_URI="git://github.com/Rogentos/rogentos-live.git"
EGIT_BRANCH="serverconf-test"

inherit eutils systemd git-2

DESCRIPTION="Rogentos live image scripts and tools"
HOMEPAGE="http://www.rogentos.ro"

SLOT="0"
LICENSE="GPL-2"
KEYWORDS="amd64 arm x86"
IUSE=""

DEPEND=""
RDEPEND="!app-misc/livecd-tools
	app-admin/eselect-opengl
	dev-util/dialog
	sys-apps/gawk
	sys-apps/pciutils
	sys-apps/keyboard-configuration-helpers
	sys-apps/sed"

src_install() {
	emake DESTDIR="${D}" SYSV_INITDIR="/etc/init.d" \
		SYSTEMD_UNITDIR="$(systemd_get_unitdir)" \
		install || die
	ls -la "${WORKDIR}"/"${PN}"-"${PV}"
}
