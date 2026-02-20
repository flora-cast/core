#!/usr/bin/env sh
set -e

NAME="gcc"
DEPENDS=""
BUILD_DEPENDS="make curl build-base autoconf automake gmp-dev mpfr-dev mpc1-dev isl-dev zlib-dev flex bison texinfo perl tar xz musl-dev linux-headers"
DESC="GNU C Compiler Collection (C/C++)"
LICENSE="GNU General Public License version 3"
VERSION="15.2.0"
SOURCE="https://ftp.gnu.org/gnu/gcc/gcc-${VERSION}/gcc-${VERSION}.tar.xz"
IS_BUILD="false"

build() {
  tar -xvf "$SOURCE_FILE" -C "$BUILD_DIR"

  cd "$BUILD_DIR/gcc-${VERSION}" 
  mkdir build; cd build

  ../configure \
    --prefix="/usr" \
    --enable-languages=c,c++ \
    --disable-multilib \
    --target=x86_64-linux-musl \
    --disable-bootstrap  &&
  make -j$(nproc)

}

package() {
  cd "$BUILD_DIR/gcc-${VERSION}/build" &&
    make DESTDIR="${PACKAGE_DIR}" install
}

pre_inst() {
  :
}

post_inst() {
  ln -s /usr/lib/libc.so /usr/lib/ld-musl-x86_64.so.1 &&
  ln -s /usr/lib/ld-musl-x86_64.so.1 /usr/bin/ldd
}

pre_rm() {
  :
}

post_rm() {
  :
}
