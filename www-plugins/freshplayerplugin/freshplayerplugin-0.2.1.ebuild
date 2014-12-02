# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/media-sound/apulse/apulse-0.1.4.ebuild,v 1.1 2014/12/01 15:59:48 jauhien Exp $

EAPI=5

inherit eutils cmake-multilib nsplugins

DESCRIPTION="ppapi2npapi compatibility layer"
HOMEPAGE="https://github.com/i-rinat/freshplayerplugin"
SRC_URI="https://github.com/i-rinat/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"

LICENSE="MIT LGPL-2.1"
SLOT="0"

KEYWORDS="~amd64 ~x86"

DEPEND="
	dev-util/ragel
	dev-libs/libconfig
	>=dev-libs/glib-2.38.2-r1:2
	>=media-libs/alsa-lib-1.0.28
	>=x11-libs/pango-1.36.5
	>=media-libs/mesa-10.0.4
	>=dev-libs/libevent-2.38.2-r1"
RDEPEND="
	www-plugins/chrome-binary-plugins"

S="${WORKDIR}/${PN}-${PV}"

src_prepare() {
	epatch "${FILESDIR}"/find-chrome-binary-plugins-flash.patch
}

multilib_src_configure() {
	local mycmakeargs="-DFRESHPLAYERPLUGINPATH=${EPREFIX}/usr/$(get_libdir)/freshplayerplugin"

	cmake-utils_src_configure
}

multilib_src_install() {
		# install the wrapper
		exeinto /usr/$(get_libdir)/${PLUGINS_DIR}
		doexe libfreshwrapper-pepperflash.so
		# install wrapper configuration file
		cd "${S}"
		dodir /usr/share/${PN} || die
		insinto /usr/share/${PN} || die
		doins -r "${S}"/data/freshwrapper.conf.example || die
		dosym /usr/share/${PN}/freshwrapper.conf.example /etc/freshwrapper.conf || die
}
