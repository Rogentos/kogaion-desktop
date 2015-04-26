# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=5

inherit eutils unpacker toolchain-funcs multilib

DESCRIPTION="utility to manage compilers"
HOMEPAGE="http://git.overlays.gentoo.org/gitweb/?p=proj/gcc-config.git"
SRC_URI="mirror://gentoo/${P}.tar.xz
	http://dev.gentoo.org/~vapier/dist/${P}.tar.xz"

LICENSE="GPL-2"
SLOT="0"
KEYWORDS="alpha amd64 arm hppa ia64 m68k ~mips ppc ppc64 s390 sh sparc x86 ~amd64-fbsd ~sparc-fbsd ~x86-fbsd"
IUSE="+systemd"
DEPEND="
	systemd? ( >=sys-apps/gentoo-functions-0.7 )"

src_prepare() {
	unpacker_src_unpack
	cd "${S}" || die
	epatch "${FILESDIR}/${PN}-kogaion-base-gcc-support.patch"
	# systemd-only systems (Kogaion/Sabayon) support
	if use systemd; then
		epatch "${FILESDIR}/${PN}-systemd.patch"
	fi
}

src_compile() {
	emake CC="$(tc-getCC)" || die
}

src_install() {
	emake \
		DESTDIR="${D}" \
		PV="${PV}" \
		SUBLIBDIR="$(get_libdir)" \
		install || die
}

pkg_postinst() {
	# Scrub eselect-compiler remains
	rm -f "${ROOT}"/etc/env.d/05compiler &

	# Make sure old versions dont exist #79062
	rm -f "${ROOT}"/usr/sbin/gcc-config &

	# We not longer use the /usr/include/g++-v3 hacks, as
	# it is not needed ...
	rm -f "${ROOT}"/usr/include/g++{,-v3} &

	# Do we have a valid multi ver setup ?
	local x
	for x in $(gcc-config -C -l 2>/dev/null | awk '$NF == "*" { print $2 }') ; do
		gcc-config ${x}
	done

	wait
}
