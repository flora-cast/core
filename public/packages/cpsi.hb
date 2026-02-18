#!/usr/bin/env sh

NAME="cpsi"
DEPENDS=""
BUILD_DEPENDS="curl busybox"
DESC="Package Manager for Shary OS"
LICENSE="BSD-3-Clause License"
VERSION="v0.1.0-amary.2"
SOURCE="https://github.com/flora-cast/cpsi/archive/refs/tags/${VERSION}.tar.gz"
IS_BUILD="false"

build() {
  mkdir -p "${BUILD_DIR}/src"
  mkdir -p "${BUILD_DIR}/zig"
  tar -xvf "${SOURCE_FILE}" -C "${BUILD_DIR}"

    cd "${BUILD_DIR}/cpsi-0.1.0-amary.2" && make
}

package() {
  cd "${BUILD_DIR}/cpsi-0.1.0-amary.2" && PREFIX="${PACKAGE_DIR}" make install
}

pre_inst() {
  :
}

post_inst() {
  :
}

pre_rm() {
  :
}

post_rm() {
  :
}
