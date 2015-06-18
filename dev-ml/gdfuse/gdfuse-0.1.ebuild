# Copyright 1999-2012 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: $

EAPI=4

inherit oasis

DESCRIPTION="FUSE filesystem over Google Drive"
HOMEPAGE="http://gdfuse.forge.ocamlcore.org/"
SRC_URI="http://forge.ocamlcore.org/frs/download.php/1000/google-drive-ocamlfuse-0.1-src.tar.gz"

LICENSE="MIT"
SLOT="0"
KEYWORDS="~x86"
IUSE="doc"

DEPEND=">=dev-ml/gapi-ocaml-0.1.15
		>=dev-ml/ocaml-sqlite3-1.6.1
		>=dev-ml/ocamlfuse-2.7.1"
RDEPEND="${DEPEND}"
S="${WORKDIR}/google-drive-ocamlfuse-0.1"
DOCS=( "README.md" \
	"doc/Authorization.md" "doc/Configuration.md" "doc/Home.md" )
