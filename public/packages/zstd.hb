#!/usr/bin/env sh


NAME="zstd"
DEPENDS=""
BUILD_DEPENDS="musl-dev gcc make gzip tar"
DESC="Fast real-time compression algorithm"
LICENSE="BSD OR GPLv2 license"
VERSION="1.5.7"
SOURCE="https://github.com/facebook/zstd/releases/download/v1.5.7/zstd-1.5.7.tar.gz"
IS_BUILD="false"

build() {
  tar -xf "$SOURCE_FILE" -C "$BUILD_DIR"

  cd "$BUILD_DIR/zstd-1.5.7" && 
    make -j$(nproc)
}

package() {
  cd "$BUILD_DIR/zstd-1.5.7" &&
    mkdir -p "$PACKAGE_DIR/usr"
    make install DESTDIR="$PACKAGE_DIR/usr"
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
