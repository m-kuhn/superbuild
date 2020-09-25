#!/bin/bash

DIR=$(cd `dirname $0` && pwd)/..

export TARGET_SUFFIX="-${TARGET}"
export SUPERBUILD_INSTALL_DIR=${DIR}/install
export ANDROID_PLATFORM="android-21"

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

