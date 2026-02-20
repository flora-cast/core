#!/usr/bin/env sh


NAME="finit"
DEPENDS=""
BUILD_DEPENDS="gcc autoconf automake pkgconf build-base linux-headers"
DESC="Fast init for Linux. Cookies included "
LICENSE="CC0"
VERSION="4.15"
SOURCE="https://github.com/finit-project/finit/releases/download/${VERSION}/finit-${VERSION}.tar.gz"
IS_BUILD="false"


build() {
  libite_version="2.6.2"
  libuev_version="2.4.1"
  
  curl -fL "https://github.com/troglobit/libite/releases/download/v${libite_version}/libite-${libite_version}.tar.gz" -o "${BUILD_DIR}/libite.tar.gz"
  curl -fL "https://github.com/troglobit/libuev/releases/download/v${libuev_version}/libuev-${libuev_version}.tar.gz" -o "${BUILD_DIR}/libuev.tar.gz"

  echo "Unpacking libite..."
  tar -xf "${BUILD_DIR}/libite.tar.gz" -C "${BUILD_DIR}"

  echo "Unpacking libuev..."
  tar -xf "${BUILD_DIR}/libuev.tar.gz" -C "${BUILD_DIR}"

  echo "Unpacking finit ${VERSION}..."
  tar -xvf "${SOURCE_FILE}" -C "${BUILD_DIR}"
  

  echo "Building libite..."
  cd "${BUILD_DIR}/libite-${libite_version}" &&
	./configure --enable-static &&
	make -j$(nproc) &&
	make install

  echo "Building libuev..."
  cd "${BUILD_DIR}/libuev-${libuev_version}" &&
	./configure --enable-static &&
	make -j$(nproc) &&
	make install
  

  cd "${BUILD_DIR}/finit-${VERSION}" &&
    ./configure --enable-static --prefix="/usr/" &&
    make -j$(nproc) &&
    make DESTDIR=$(realpath "${PACKAGE_DIR}") install 
}

package() {
  :
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
