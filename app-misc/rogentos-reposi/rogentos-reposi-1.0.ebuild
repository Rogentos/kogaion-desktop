# Copyright 2012 Rogentos Linux
# Distributed under the terms of the GNU General Public License v2
# Maintainer BlackNoxis <stefan.cristian at rogentos.ro>
# $Header: $

EAPI=5

DESCRIPTION="Offical Rogentos Stability Watcher"
HOMEPAGE="http://www.rogentos.ro"
SRC_URI=""

LICENSE="GPL-v2"
SLOT="0"
KEYWORDS="~x86 ~amd64"
IUSE=""
RDEPEND="app-admin/equo
	!app-misc/sabayon-version"
DEPEND="${RDEPEND}"

S="${WORKDIR}"

src_install() {
        ewarn "This is available for only Entropy package manager" || die
        insinto /etc/entropy/repositories.conf.d/
        doins "${FILESDIR}"/entropy* || die
		insinto /opt/reupdate/
		doins "${FILESDIR}"/reupdate
		fperms u+x /opt/reupdate/reupdate
		dosym /opt/reupdate/reupdate /usr/bin/reupdate
}

pkg_postinst() {
	einfo "Please report bugs or glitches to"
	einfo "stefan.cristian [aaron] rogentos.ro"
}
