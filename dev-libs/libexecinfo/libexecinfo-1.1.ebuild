# Copyright 1999-2020 Gentoo Authors
# Distributed under the terms of the GNU General Public License v2

EAPI=7

inherit flag-o-matic

DESCRIPTION="A quick-n-dirty BSD licensed clone of the GNU libc backtrace facility."
HOMEPAGE="https://www.freshports.org/devel/libexecinfo"
SRC_URI="http://distcache.freebsd.org/local-distfiles/itetcu/${P}.tar.bz2"

LICENSE="BSD-2"
SLOT="0"
KEYWORDS="~amd64 ~arm ~arm64 ~mips ~ppc ~ppc64 ~x86"
IUSE=""

DEPEND="sys-libs/musl"
RDEPEND="${DEPEND}"
BDEPEND=""

PATCHES=(
	"${FILESDIR}"/10-execinfo.patch
	"${FILESDIR}"/20-define-gnu-source.patch
	"${FILESDIR}"/30-linux-makefile.patch
	"${FILESDIR}"/gentoo_use_portage_flags.patch
)

src_prepare() {
	default
}

src_compile() {
	append-cflags -fno-omit-frame-pointer
	emake
}

src_install() {
	mkdir -p "${D}/usr/include"
	mkdir -p "${D}/usr/lib"
	cp "${S}/execinfo.h" "${D}/usr/include/execinfo.h"
	cp "${S}/stacktraverse.h" "${D}/usr/include/stacktraverse.h"
	cp "${S}/libexecinfo.a" "${D}/usr/lib/libexecinfo.a"
	cp "${S}/libexecinfo.so.1" "${D}/usr/lib/libexecinfo.so.1"
	ln -sf libexecinfo.so.1 "${D}/usr/lib/libexecinfo.so"
}
