#!/usr/bin/env sh


NAME="cacert"
DEPENDS=""
BUILD_DEPENDS=""
DESC="The Mozilla CA certificate store in PEM format"
LICENSE="CC0"
VERSION="1.0.0"
SOURCE="https://curl.se/ca/cacert.pem"
IS_BUILD="false"

build() {
  :
}

package() {
  mkdir -p "${PACKAGE_DIR}/etc/ssl/certs/"
  cp "$SOURCE_FILE" "${PACKAGE_DIR}/etc/ssl/certs/cacert-$(date '+%Y-%m-%d').pem"
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
