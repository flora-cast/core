#!/usr/bin/env sh


NAME="busybox"
DEPENDS=""
BUILD_DEPENDS=""
DESC="BusyBox combines tiny versions of many common UNIX utilities into a single small executable."
LICENSE="GPL-2.0"
VERSION="1.35.0"
SOURCE="https://busybox.net/downloads/binaries/${VERSION}-x86_64-linux-musl/busybox"
IS_BUILD="false"

build() {
  mkdir -p "$PACKAGE_DIR/usr/bin"
  cp "$SOURCE_FILE" "$PACKAGE_DIR/usr/bin/busybox"
}

package() {
  cd "$PACKAGE_DIR/usr/bin" && chmod +x ./busybox && ./busybox --install -s .
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
