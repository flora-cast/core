#!/usr/bin/env sh


NAME="musl"
DEPENDS=""
BUILD_DEPENDS="musl-dev gcc make"
DESC="an implementation of the standard library for Linux-based systems"
LICENSE="MIT License"
VERSION="1.2.5"
SOURCE="https://musl.libc.org/releases/musl-1.2.5.tar.gz"
IS_BUILD="false"

build() {
  tar -xf "$SOURCE_FILE" -C "$BUILD_DIR"

  cd "$BUILD_DIR/musl-${VERSION}" && 
    mkdir -p "$PACKAGE_DIR/usr" && 
    ./configure --prefix="$PACKAGE_DIR/usr/" &&
    make -j$(nproc) 
}

package() {
  cd "$BUILD_DIR/musl-${VERSION}" &&
    make install 
}

pre_inst() {
  :
}

post_inst() {
  mkdir -p /usr/lib
  ln -sf /usr/lib/libc.so /usr/lib/ld-musl-x86_64.so.1 &&
  ln -sf /usr/lib/ld-musl-x86_64.so.1 /usr/bin/ldd
}

pre_rm() {
  :
}

post_rm() {
  :
}
