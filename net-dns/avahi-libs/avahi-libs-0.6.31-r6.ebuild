# Copyright 1999-2014 Sabayon
# Copyright 2015 Rogentos Group
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI="5"

AVAHI_MODULE="${AVAHI_MODULE:-${PN/avahi-}}"
MY_P=${P/-${AVAHI_MODULE}}
MY_PN=${PN/-${AVAHI_MODULE}}

WANT_AUTOMAKE=1.11

PYTHON_COMPAT=( python{2_6,2_7} )
PYTHON_REQ_USE="gdbm"

inherit autotools eutils flag-o-matic multilib multilib-minimal \
	python-r1 systemd user

DESCRIPTION="System which facilitates service discovery on a local network (gtk3 pkg)"
HOMEPAGE="http://avahi.org/"
SRC_URI="http://avahi.org/download/${MY_P}.tar.gz"

LICENSE="LGPL-2.1"
SLOT="0"
KEYWORDS="~alpha amd64 ~arm ~hppa ~ia64 ~mips ~ppc ~ppc64 ~s390 ~sh ~sparc x86 ~amd64-fbsd ~x86-fbsd ~x86-linux"
IUSE="bookmarks dbus gdbm introspection nls python utils"

S="${WORKDIR}/${MY_P}"

COMMON_DEPEND=""
DEPEND="${COMMON_DEPEND}"
RDEPEND="${COMMON_DEPEND}"

MULTILIB_WRAPPED_HEADERS=(
	# necessary until the UI libraries are ported
	/usr/include/avahi-ui/avahi-ui.h
)

src_prepare() {
	# Make gtk utils optional
	epatch "${FILESDIR}"/${MY_PN}-0.6.30-optional-gtk-utils.patch

	# Fix init scripts for >=openrc-0.9.0, bug #383641
	epatch "${FILESDIR}"/${MY_PN}-0.6.x-openrc-0.9.x-init-scripts-fixes.patch

	# install-exec-local -> install-exec-hook
	epatch "${FILESDIR}"/${MY_P}-install-exec-hook.patch

	# Backport host-name-from-machine-id patch, bug #466134
	epatch "${FILESDIR}"/${MY_P}-host-name-from-machine-id.patch

	# Don't install avahi-discover unless ENABLE_GTK_UTILS, bug #359575
	epatch "${FILESDIR}"/${MY_P}-fix-install-avahi-discover.patch

	epatch "${FILESDIR}"/${MY_P}-so_reuseport-may-not-exist-in-running-kernel.patch

	# allow building client without the daemon
	epatch "${FILESDIR}"/${MY_P}-build-client-without-daemon.patch

	# Drop DEPRECATED flags, bug #384743
	sed -i -e 's:-D[A-Z_]*DISABLE_DEPRECATED=1::g' avahi-ui/Makefile.am || die

	# Fix references to Lennart's home directory, bug #466210
	sed -i -e 's/\/home\/lennart\/tmp\/avahi//g' man/* || die

	# Prevent .pyc files in DESTDIR
	>py-compile

	# bundled manpages
	multilib_copy_sources
}

src_configure() {
	# those steps should be done once-per-ebuild rather than per-ABI
	use sh && replace-flags -O? -O0

	# We need to unset DISPLAY, else the configure script might have problems detecting the pygtk module
	unset DISPLAY
}

src_install() {
	if use abi_x86_32 ; then
		insinto /usr/include/
		doins avahi-ui/avahi-ui.h
		insinto /usr/include/${CHOST}/avahi-ui/
		doins "${WORKDIR}"/avahi-0.6.31-abi_x86_32.x86/avahi-ui/avahi-ui.h
	elif use abi_x86_64 ; then
		insinto /usr/include/
		doins avahi-ui/avahi-ui.h
		insinto /usr/include/${CHOST}/avahi-ui/
		doins "${WORKDIR}"/avahi-0.6.31-abi_x86_64.amd64/avahi-ui/avahi-ui.h
	fi
}
