# Copyright 1999-2015 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI="4"

PATCH_VER="1.6"
UCLIBC_VER="1.0"

# Hardened gcc 4 stuff
PIE_VER="0.6.1"
SPECS_VER="0.2.0"
SPECS_GCC_VER="4.4.3"
# arch/libc configurations known to be stable with {PIE,SSP}-by-default
PIE_GLIBC_STABLE="x86 amd64"
PIE_UCLIBC_STABLE="x86 amd64"
SSP_STABLE="amd64 x86"
# uclibc need tls and nptl support for SSP support
# uclibc need to be >= 0.9.33
SSP_UCLIBC_STABLE="x86 amd64"
#end Hardened stuff

inherit eutils toolchain

KEYWORDS="~amd64 ~x86"

RDEPEND=""
DEPEND="${RDEPEND}
	elibc_glibc? ( >=sys-libs/glibc-2.8 )
	>=${CATEGORY}/binutils-2.20"

if [[ ${CATEGORY} != cross-* ]] ; then
	PDEPEND="${PDEPEND} elibc_glibc? ( >=sys-libs/glibc-2.8 )"
fi

src_prepare() {
	if has_version '<sys-libs/glibc-2.12' ; then
		ewarn "Your host glibc is too old; disabling automatic fortify."
		ewarn "Please rebuild gcc after upgrading to >=glibc-2.12 #362315"
		EPATCH_EXCLUDE+=" 10_all_default-fortify-source.patch"
	fi

	toolchain_src_prepare

	use vanilla && return 0
	#Use -r1 for newer piepatchet that use DRIVER_SELF_SPECS for the hardened specs.
	[[ ${CHOST} == ${CTARGET} ]] && epatch "${FILESDIR}"/gcc-spec-env-r1.patch
}

src_install() {
	# first, install full gcc
	toolchain_src_install
	
	# define folders to be dropped, as they are provided by sys-devel/gcc-${PV}
	export local bindir="${D}usr/bin"
	export local libexecdir="${D}usr/libexec"
	export local usrdir="${D}usr/$(uname -m)-pc-linux-gnu"
	export local sharedir="${D}usr/share"
	export local debugdir="${D}usr/lib/debug"
	export local libdir="${D}usr/lib/gcc/$(uname -m)-pc-linux-gnu/${PV}"
	if use multilib ; then
		export local multilibdir="${D}usr/lib/gcc/$(uname -m)-pc-linux-gnu/${PV}/32"
	fi
	
	# drop binaries, debug symbols && headers, they're provided by sys-devel/gcc-${PV}
	for extra in "$bindir" "$libexecdir" "$usrdir" "$sharedir" "$debugdir" "$libdir/include" "$libdir/finclude" "$libdir/include-fixed" "$libdir/plugin" "$libdir/security" ; do
		rm -rf "$extra"
	done
}

pkg_preinst() {
	:
}

pkg_postinst() {
	# RogentOS specific bits to always force the latest gcc profile
	export local gcc_atom=$(best_version sys-devel/base-gcc)
	export local gcc_ver=
	if [[ -n "${gcc_atom}" ]] ; then
		elog "Found latest base-gcc to be: ${gcc_atom}, forcing this profile"
		gcc_ver=$(portageq metadata "${ROOT}" installed "${gcc_atom}" PV)
	else
		eerror "No sys-devel/base-gcc installed"
	fi

	if [[ -n "${gcc_ver}" ]] ; then
		export local target="${CTARGET:${CHOST}}-${gcc_ver}"
		export local env_target="${ROOT}/etc/env.d/gcc/${target}"
		if [[ -e "${env_target}-vanilla" ]] ; then
			elog "Setting: ${target} GCC profile"
			gcc-config "${target}"
		fi
	else
		eerror "No sys-devel/base-gcc version installed? Cannot set a proper GCC profile"
	fi
}
