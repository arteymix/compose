#!/bin/sh

mkdir -p ${MESON_INSTALL_DESTDIR_PREFIX}/include/compose-1.0
install ${MESON_BUILD_ROOT}/src/compose.h ${MESON_INSTALL_DESTDIR_PREFIX}/include/compose-1.0

mkdir -p ${MESON_INSTALL_DESTDIR_PREFIX}/share/vala/vapi
install ${MESON_BUILD_ROOT}/src/compose-1.0.vapi ${MESON_INSTALL_DESTDIR_PREFIX}/share/vala/vapi
