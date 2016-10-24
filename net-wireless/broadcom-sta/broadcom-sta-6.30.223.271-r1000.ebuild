# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5
inherit eutils

DESCRIPTION="Broadcom's IEEE 802.11a/b/g/n hybrid Linux device driver"
HOMEPAGE="http://www.broadcom.com/support/802.11/"
SRC_BASE="http://www.broadcom.com/docs/linux_sta/hybrid-v35"
SRC_URI=""

LICENSE="Broadcom"
KEYWORDS="amd64 x86"

RESTRICT="mirror"
SLOT="0"

DEPEND="=sys-kernel/${PN}-dkms-${PV}"
RDEPEND="${DEPEND}"

S=${WORKDIR}

src_install() {
	:
}
