#!/usr/bin/env sh


NAME="make"
DEPENDS=""
BUILD_DEPENDS="gcc lzip"
DESC="GNU Make is a build automation tool that compiles and manages project files automatically based on defined dependencies"
LICENSE="GPL-3.0-or-later AND LGPL-2.1-or-later AND GFDL-1.3-or-later AND FSFULLR"
VERSION="4.4"
SOURCE="https://ftp.gnu.org/gnu/make/make-4.4.tar.lz"
IS_BUILD="false"

build() {
  tar -xf "$SOURCE_FILE" -C "$BUILD_DIR"

  cd "$BUILD_DIR/make-${VERSION}" && 
	./configure &&
	./build.sh
}

package() {
  cd "$BUILD_DIR/make-${VERSION}" &&
    ./make install 
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
