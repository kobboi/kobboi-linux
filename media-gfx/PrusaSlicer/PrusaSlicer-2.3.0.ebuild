# Copyright 1999-2017 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2

EAPI=6

inherit eutils cmake-utils

DESCRIPTION="Prusa Edition of a mesh slicer to generate G-code for fused-filament-fabrication (3D printers)"
HOMEPAGE="https://github.com/prusa3d/PrusaSlicer"
SRC_URI="https://github.com/prusa3d/PrusaSlicer/archive/version_${PV}.tar.gz"

LICENSE="AGPL-3"
SLOT="0"
KEYWORDS="~amd64"
IUSE="+gui test"

# https://github.com/prusa3d/PrusaSlicer/issues/2150
RDEPEND=">=dev-libs/boost-1.55[threads]
  dev-cpp/eigen
  dev-cpp/tbb
  >=sci-mathematics/cgal-5
  dev-libs/cereal
  dev-libs/expat
  media-gfx/openvdb[abi7-compat]
  media-libs/glew:0
  net-misc/curl
  sci-libs/nlopt[cxx]
  gui? ( >=media-libs/freeglut-3
    x11-libs/libXmu
    x11-libs/wxGTK:3.0
  )"
DEPEND="${RDEPEND}
  >=dev-cpp/gtest-1.7"

S="${WORKDIR}/PrusaSlicer-version_${PV}"

src_prepare() {
  epatch "${FILESDIR}/boost-1.73.patch"
  pushd "${WORKDIR}/PrusaSlicer-version_${PV}" || die
  eapply_user
  popd || die
}

src_configure() {
  CMAKE_BUILD_TYPE=Release

  local mycmakeargs=(
    -DSLIC3R_WX_STABLE=1
    -DSLIC3R_FHS=1
    -DSLIC3R_BUILD_ID=PrusaSlicer-${PV}
  )

  sed -i "s|\+UNKNOWN||g" version.inc

  cmake-utils_src_configure
}

src_test() {
  cmake-utils_src_test
}

src_install() {
  cmake-utils_src_install 

  make_desktop_entry prusa-slicer \
    "PrusaSlicer" \
    "/usr/share/${PN}/icons/PrusaSlicer_128px.png" \
    "Graphics;3DGraphics;Engineering;Development"
}
