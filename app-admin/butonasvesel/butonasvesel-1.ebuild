# Copyright 2013 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5" #EAPI, read docs for this. natural we use 5, but there must be a src_prepare() at least with something in it

inherit eutils #Object-oriented packaging, inherit classes with functions that will follow

DESCRIPTION="The most interesting button you have ever seen in your life"
HOMEPAGE="http://rogentos.ro"
SRC_URI="http://pkg.rogentos.ro/~rogentos/distro/"${PN}"/"${PN}".tar.gz"

LICENSE="GPL-2"
SLOT="0" #How many times do you want this package to exist/to be installed, to coexist in different versions
KEYWORDS="~* ~amd64 ~x86" #Every architecture you like
IUSE="" #Configure flags, also known as ./configure --features --enable/disable features to be used

RDEPEND="" #runtime deps
DEPEND="" #build deps
COMMON_DEPEND="" #Your deps, if you want to handle your own dep-control

S="${WORKDIR}"/${PN}/ # PN means the name of the ebuild. http://devmanual.gentoo.org/ebuild-writing/variables/

# The next step must be used in anyway possible for the EAPI=5 to be valid
# Naturally, you can start by using insinto functions 
src_prepare() { #unpacked files in the sandbox can be easily modified before all instalation process in this way
	insinto "${S}"/${PN}/ || die "Failed to cd into directory"
	emake || die "Failed to emake"
}

src_install() {
	insinto /usr/sbin/
	doins "${S}"/"${PN}" || die "Failed to copy compiled file" # Again, S means workdir and PN is helloworld
	fperms 755 /usr/sbin/"${PN}"
	elog "Some people don't know what to do with their 5:00 AM time"
	elog "...while compiling hundreds of packages and turn them"
	elog "into a useful ISO for people to use"
}

