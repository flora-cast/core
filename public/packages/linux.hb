#!/usr/bin/env sh


NAME="linux"
DEPENDS="base"
BUILD_DEPENDS="gcc make bc bison perl python3 xz-utils"
DESC="Linux kernel for Lilith Linux"
LICENSE="GPL-2.0"
VERSION="6.18"
SOURCE="https://cdn.kernel.org/pub/linux/kernel/v6.x/linux-${VERSION}.tar.xz"
IS_BUILD="false"

build() {
  tar -xf "$SOURCE_FILE" -C "$BUILD_DIR"
  cd "$BUILD_DIR/linux-${VERSION}" 

  if ! [ -f /boot/old-config ]; then
    cat ./linux/config-${VERSION}-shary-os > ./.config
  else
    cp /boot/old-config ./.config 
  fi

  make -j$(nproc)
}

package() {
  cd "$BUILD_DIR/linux-${VERSION}" &&
    mkdir -p "$PACKAGE_DIR/usr/src/linux-${VERSION}" "$PACKAGE_DIR/boot" &&
    cp ./.config "$PACKAGE_DIR/boot/old-config" &&
    cp ./arch/x86/boot/bzImage "$PACKAGE_DIR/boot/vmlinuz" &&
    make modules_install INSTALL_MOD_PATH="$PACKAGE_DIR/usr"
}

pre_inst() {
  :
}

post_inst() {
  ln -s /boot/vmlinuz /boot/vmlinuz-${VERSION}
}

pre_rm() {
  :
}

post_rm() {
  :
}
