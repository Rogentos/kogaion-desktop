# Copyright 1999-2016 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Id$

EAPI=5

inherit eutils git-2 cmake-utils

DESCRIPTION="Create a Kwallet/Gnome-keyring like functionality for lxqt"
HOMEPAGE="https://github.com/mhogomchungu/lxqt_wallet"

EGIT_REPO_URI="https://github.com/mhogomchungu/lxqt_wallet.git"
EGIT_COMMIT="1ad0c22c169c6fa43b767ae8bdbc972af376b8d1"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="amd64 x86"
IUSE="kwallet +libsecret"

DEPEND="dev-qt/qtcore:5
	dev-qt/qtgui:5
	dev-qt/qtwidgets:5
	dev-qt/linguist-tools:5
	libsecret? (
		app-crypt/libsecret
	)
	kwallet? (
		kde-frameworks/kwallet
		kde-frameworks/knotifications
	)"
RDEPEND="${DEPEND}"

src_configure() {
	if use kwallet && use libsecret ; then
		local mycmakeargs=(
			-DNOKDESUPPORT=false -DNOSECRETSUPPORT=false)
	elif ! use kwallet && use libsecret ; then
		local mycmakeargs=(
			-DNOKDESUPPORT=true -DNOSECRETSUPPORT=false)
	elif use kwallet && ! use libsecret ; then
		local mycmakeargs=(
			-DNOKDESUPPORT=false -DNOSECRETSUPPORT=true)
	elif ! use kwallet && ! use libsecret ; then
		local mycmakeargs=(
			-DNOKDESUPPORT=true -DNOSECRETSUPPORT=true)
	fi
	cmake-utils_src_configure
}
