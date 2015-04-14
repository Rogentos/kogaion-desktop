# Copyright 2004-2011 Sabayon Linux
# Copyright 2012 Rogentos Linux
# Original Authors Sabayon Team
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=3

DESCRIPTION="Rogentos System Release virtual package"
HOMEPAGE="http://rogentos.ro/"
SRC_URI=""

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~x86"

IUSE=""
DEPEND=""
RDEPEND="app-eselect/eselect-python
	dev-lang/python:2.7
	sys-devel/base-gcc:4.6
	sys-devel/gcc-config"

ROGENTOS_VER="${PV}"
ROGENTOS_HEADER="Rogentos Linux"
ROGENTOS_RELEASE="rogentos-release"

src_unpack () {
	if use x86; then
		echo "${ROGENTOS_HEADER} x86 ${ROGENTOS_VER}" > "${ROGENTOS_RELEASE}"
	else
		echo "${ROGENTOS_HEADER} amd64 ${ROGENTOS_VER}" > "${ROGENTOS_RELEASE}"
	fi
}

src_install () {
	insinto /etc
	doins rogentos-release
	dosym /etc/rogentos-release /etc/system-release
	# Adding sabayon anti-fork bomb
        insinto /etc/security/limits.d
        doins "${FILESDIR}/00-sabayon-anti-fork-bomb.conf"
}

pkg_postinst() {
	# Setup Python 2.7
	eselect python update --ignore 3.0 --ignore 3.1 --ignore 3.2 --ignore 3.3 --ignore 3.4
}
