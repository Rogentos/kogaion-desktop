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
PIE_GLIBC_STABLE="x86 amd64 mips ppc ppc64 arm ia64"
PIE_UCLIBC_STABLE="x86 arm amd64 mips ppc ppc64"
SSP_STABLE="amd64 x86 mips ppc ppc64 arm"
# uclibc need tls and nptl support for SSP support
# uclibc need to be >= 0.9.33
SSP_UCLIBC_STABLE="x86 amd64 mips ppc ppc64 arm"
#end Hardened stuff

inherit eutils toolchain

KEYWORDS="amd64 x86"

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
	cd "${WORKDIR}/build"
	emake -j1 -C "${CTARGET}/libgcc" DESTDIR="${D}" install-shared || die
	if use multilib ; then
		emake -j1 -C "${CTARGET}/32/libgcc" DESTDIR="${D}" install-shared || die
	fi
	
	if use mudlap ; then
		emake -j1 -C "${CTARGET}/libmudflap" DESTDIR="${D}" install-toolexeclibLTLIBRARIES || die
		if use multilib ; then
			emake -j1 -C "${CTARGET}/32/libmudflap" DESTDIR="${D}" install-toolexeclibLTLIBRARIES || die
		fi		
	fi
	
	if use openmp ; then
		emake -j1 -C "${CTARGET}/libgomp" DESTDIR="${D}" install-toolexeclibLTLIBRARIES || die
		if use multilib ; then
			emake -j1 -C "${CTARGET}/32/libgomp" DESTDIR="${D}" install-toolexeclibLTLIBRARIES || die
		fi
	fi
	
	for lib in "libatomic" "libitm" "libsanitizer/asan" "libstdc++-v3/src" ; do
		emake -j1 -C "${CTARGET}/$lib" DESTDIR="${D}" install-toolexeclibLTLIBRARIES || die
	done
	if use multilib ; then
		for lib in "libatomic" "libitm" "libsanitizer/asan" "libstdc++-v3/src" ; do
			emake -j1 -C "${CTARGET}/32/$lib" DESTDIR="${D}" install-toolexeclibLTLIBRARIES || die
		done
	fi

	if use quadmath ; then
		emake -j1 -C "${CTARGET}/libquadmath" DESTDIR="${D}" install-toolexeclibLTLIBRARIES || die
		if use multilib ; then
			emake -j1 -C "${CTARGET}/32/libquadmath" DESTDIR="${D}" install-toolexeclibLTLIBRARIES || die
		fi
	fi
	
	if use fortran ; then
		emake -j1 -C "${CTARGET}/libgfortran" DESTDIR="${D}" install-toolexeclibLTLIBRARIES || die
		if use multilib ; then
			emake -j1 -C "${CTARGET}/32/libgfortran" DESTDIR="${D}" install-toolexeclibLTLIBRARIES || die
		fi
	fi
	
	if use objc ; then
		emake -j1 -C "${CTARGET}/libobjc" DESTDIR="${D}" install-libs || die
		if use multilib ; then	
			emake -j1 -C "${CTARGET}/32/libobjc" DESDIR="${D}" install-libs || die
		fi
	fi
	
	dodit /etc/env.d/gcc
	create_gcc_ent_entry
	
	if want_minispecs ; then
		copy_minispecs_gcc_specs
	fi
}

pkg_preinst() {
	:
}

pkg_postinst() {
	:
}
