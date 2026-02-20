#!/usr/bin/env sh


NAME="base"
DEPENDS="tar"
BUILD_DEPENDS=""
DESC="Base filesystem for lilith linux"
LICENSE="BSD-3-Clause License"
VERSION="1.1.0"
SOURCE="https://github.com/lilith-linux/base/archive/refs/tags/${VERSION}.tar.gz"
IS_BUILD="false"

build() {
  tar -xf "$SOURCE_FILE" -C "$BUILD_DIR"

  cd "$BUILD_DIR/base-${VERSION}" && 
    find . -name ".gitkeep" | xargs rm -f
}

package() {
  cd "$BUILD_DIR/base-${VERSION}" &&
    cp * "$PACKAGE_DIR" -r
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
