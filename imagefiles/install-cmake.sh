#!/bin/bash

#
# Configure, build and install CMake
#
# Usage:
#
#  install-cmake.sh [-32]
#
# Options:
#
#  -32                 Build CMake as a 32-bit executable
#
# Notes:
#
#  * build directory is /usr/src/CMake
#
#  * install directory is /usr
#
#  * after installation, archive, source and build directories are removed
#

set -e
set -o pipefail

WRAPPER=""
CONFIG_FLAG=""
SUFFIX=64

while [ $# -gt 0 ]; do
  case "$1" in
    -32)
      WRAPPER="linux32"
      CONFIG_FLAG="-m32"
      SUFFIX=32
      ;;
    *)
      echo "Usage: Usage: ${0##*/} [-32]"
      exit 1
      ;;
  esac
  shift
done

cd /usr/src

# Download
CMAKE_REV=v3.9.1
wget --progress=bar:force https://github.com/kitware/cmake/archive/$CMAKE_REV.tar.gz -O CMake.tar.gz
mkdir CMake
tar -xzf ./CMake.tar.gz --strip-components=1 -C ./CMake

mkdir /usr/src/CMake-build

pushd /usr/src/CMake-build

NUM_PROCESSOR=$(grep -c processor /proc/cpuinfo)

# Configure boostrap
${WRAPPER} /usr/src/CMake/bootstrap \
  --parallel=$NUM_PROCESSOR \
  --prefix=/usr

# Build and Install
${WRAPPER} make install -j$NUM_PROCESSOR

# Test
ctest -R CMake.FileDownload

popd

rm -rf CMake*