#!/bin/bash

DIR=$(cd `dirname $0` && pwd)/..

export TARGET_SUFFIX="-${TARGET}"
export SUPERBUILD_INSTALL_DIR=${DIR}/install
export ANDROID_PLATFORM="android-21"


# Fix licences
DEST=$(SUPERBUILD_INSTALL_DIR)/share/doc/copyright
mkdir -p ${DEST}
cp /usr/share/doc/libexpat1/copyright      ${DEST}/expat-${IMAGE_NAME}.txt
cp /usr/share/doc/libjpeg-turbo8/copyright ${DEST}/libjpeg-turbo-${IMAGE_NAME}.txt
cp /usr/share/doc/liblzma5/copyright       ${DEST}/liblzma-${IMAGE_NAME}.txt
cp /usr/share/doc/libpcre3/copyright       ${DEST}/pcre3-${IMAGE_NAME}.txt
cp /usr/share/doc/libpng16-16/copyright    ${DEST}/libpng-${IMAGE_NAME}.txt
cp /usr/share/doc/libtiff5/copyright       ${DEST}/tiff-${IMAGE_NAME}.txt
cp /usr/share/doc/mingw-w64-x86-64-dev/copyright  ${DEST}/mingw-w64-x86-64-${IMAGE_NAME}.txt
cp /usr/share/doc/sqlite3/copyright        ${DEST}/sqlite3-${IMAGE_NAME}.txt
cp /usr/share/doc/zlib1g/copyright         ${DEST}/zlib-${IMAGE_NAME}.txt

# Setup build dir
mkdir ${DIR}/build
cd ${DIR}/build

cmake \
  -DENABLE_${TARGET}=1 \
  -D${TARGET}_INSTALL_DIR=${SUPERBUILD_INSTALL_DIR}/${TARGET} \
  -D${TARGET}_INSTALL_PREFIX=/usr \
  -D${TARGET}_TOOLCHAIN_DIR=${SUPERBUILD_INSTALL_DIR}/${TARGET}/toolchain \
  -DUSE_SYSTEM_SQLITE3=OFF \
  -DMapper_GIT_GDAL_DATA_DIR=${SUPERBUILD_INSTALL_DIR}/${TARGET}/usr/share/gdal \
  -DANDROID_BUILD_LIBCXX=1 \
  ..

make -j8 qgis-640f046c1c18fb3f3074e54a5a13946ff9797c3d-${TARGET}
