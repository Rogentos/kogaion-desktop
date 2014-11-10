# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=2

DESCRIPTION="Virtual for GCC needed for compiling utilities"
HOMEPAGE=""
SRC_URI=""

LICENSE=""
SLOT="0"
KEYWORDS="~amd64 ~x86"
IUSE=""

DEPEND="sys-devel/automake
	sys-devel/gcc
	sys-devel/autoconf
	sys-devel/make
	dev-util/pkgconfig"
RDEPEND="${DEPEND}"
