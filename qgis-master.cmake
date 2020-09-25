# This file is part of OpenOrienteering.

# Copyright 2016-2020 Kai Pastor
#
# Redistribution and use is allowed according to the terms of the BSD license:
#
# Redistribution and use in source and binary forms, with or without
# modification, are permitted provided that the following conditions
# are met:
# 
# 1. Redistributions of source code must retain the copyright
#    notice, this list of conditions and the following disclaimer.
# 2. Redistributions in binary form must reproduce the copyright
#    notice, this list of conditions and the following disclaimer in the
#    documentation and/or other materials provided with the distribution.
# 3. The name of the author may not be used to endorse or promote products 
#    derived from this software without specific prior written permission.
# 
# THIS SOFTWARE IS PROVIDED BY THE AUTHOR ``AS IS'' AND ANY EXPRESS OR
# IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES
# OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED.
# IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY DIRECT, INDIRECT,
# INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES (INCLUDING, BUT
# NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
# DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY
# THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
# (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF
# THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

# https://tracker.debian.org/pkg/gdal

set(version        640f046c1c18fb3f3074e54a5a13946ff9797c3d)
set(download_hash  SHA256=d76bc4083cdef0370e2215e6564ea8ec53fda4f02c70767c87440f8396b48499)
set(patch_version  ${version})
set(patch_hash     SHA256=50314f747a4813566d0005b677f83eab50c5e2b32ce23e513830724d86ae5640)
set(base_url       https://github.com/qgis/QGIS/archive/)
set(QGIS_QT_VERSION 5.15)

superbuild_package(
  NAME           qgis
  VERSION        ${patch_version}
  DEPENDS
    common-licenses
    gdal
    geos
    libzip
    protobuf
    qtandroidextras-${QGIS_QT_VERSION}
    qtbase-${QGIS_QT_VERSION}
    qtimageformats-${QGIS_QT_VERSION}
    qtlocation-${QGIS_QT_VERSION}
    qtsensors-${QGIS_QT_VERSION}
    qttools-${QGIS_QT_VERSION}
    qttranslations-${QGIS_QT_VERSION}
    host:protobuf
  
  SOURCE
    URL            ${base_url}${version}.tar.gz
    URL_HASH       ${download_hash}
  
  USING            patch_version extra_cflags extra_cxxflags
  BUILD [[
    CMAKE_ARGS
      "-DCMAKE_TOOLCHAIN_FILE=${CMAKE_TOOLCHAIN_FILE}"
      "-DCMAKE_BUILD_TYPE:STRING=$<CONFIG>"
      -DBUILD_SHARED_LIBS=ON
      -DUSE_THREAD=ON
      -DWITH_QTWEBKIT=OFF
      -DGEOS_INCLUDE_DIR=${INSTALL_DIR}/usr/include
      -DGEOS_LIBRARY=${INSTALL_DIR}/usr/lib/libgeos_c.so
      -DGDAL_INCLUDE_DIR=${INSTALL_DIR}/usr/include
      -DGDAL_LIBRARY=${INSTALL_DIR}/usr/lib/libgdal.so
    $<$<NOT:$<BOOL:@CMAKE_CROSSCOMPILING@>>:
      -DBUILD_TESTING=ON
    >
      -DWITH_QT5SERIALPORT=OFF
  ]]
)