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
		toolchain_src_install
		# drop base gcc libraries, they're provided by sys-devel/base-gcc-${PV}
		export local libdir="${D}usr/lib/gcc/${CHOST}/${PV}"
		if use multilib ; then
			export local multilibdir="${D}usr/lib/gcc/${CHOST}/${PV}/32"
		fi
		
		# if we remove whole libdir, headers are gone, so remove only libs and their symlinks
		find "$libdir" -maxdepth 1 -type f -delete
		find "$libdir" -maxdepth 1 -type l -delete
		# however, removing multilibdir as a whole doesn't cause any problems
		if use multilib ; then
			rm -rf "$multilibdir"
		fi
		
		# drop golibs, they're provided by sys-devel/base-gcc-{PV}
		if [[ "$(uname -m)" = "x86_64" ]] ; then
			export local golibdir="${D}usr/lib64/go/${PV}"
			if use multilib ; then
				export local gomultilibdir="${D}usr/lib32/go/${PV}"
			fi
		elif [[ "$(uname -m)" = "i686" ]] ; then
			export local golibdir="${D}/usr/lib/go/${PV}"
		fi

		rm -rf "$golibdir"
		if use multilib ; then
			rm -rf "$gomultilibdir"
		fi
		
		# drop gcjlibs, they're provided by sys-devel/base-gcc-${PV}
		if [[ "$(uname -m)" = "x86_64" ]] ; then
			export local gcjlibdir="${D}usr/lib64/gcj-${PV}-14"
			if use multilib ; then
				export local gcjmultilibdir="${D}usr/lib32/gcj-${PV}-14"
			fi
		elif [[ "$(uname -m)" = "i686" ]] ; then
			export local gcjlibdir="${D}usr/lib/gcj-${PV}-14"
		fi

		rm -rf "$gcjlibdir"
		if use multilib ; then
			rm -rf "$gcjmultilibdir"
		fi

		# drop pkgconfig files, they're provided by sys-devel/base-gcc-${PV}
		if [[ "$(uname -m)" = "x86_64" ]] ; then
			export local pkgconfigdir="${D}usr/lib64/pkgconfig"
			if use multilib ; then
				export local pkgconfigmultilibdir="${D}usr/lib32/pkgconfig"
			fi
		elif [[ "$(uname -m)" = "i686" ]] ; then
			export local pkgconfigdir="${D}usr/lib/pkgconfig"
		fi

		rm -rf "$pkgconfigdir"
		if use multilib ; then
			rm -rf "$pkgconfigmultilibdir"
		fi
		
		# drop gcc profiles, they're provided by sys-devel/base-gcc-${PV}
		export local envdir="${D}etc"
		rm -rf "$envdir"
}

pkg_preinst() {
	:
}

pkg_postinst() {
	:
}
