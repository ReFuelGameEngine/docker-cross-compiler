#!/bin/bash

# $1 Source path of the project.
# $2 Target architecture list.
# DST is the destination directory.
# NOINSTALL = 1 to skip installing.

SRC=$1
ARCHS=$2

if [ -z "$SRC" ]
then
    echo You need to provide a source path.
    return
fi

if [ -z "$ARCHS" ]
then
    ARCHS="linux-arm linux-arm64 linux-x64 win-x64 win-x86 osx-arm64 osx-x64"
fi

if [ -z "$DST" ]
then
    DST=$PWD
fi

if [ -z "$CMAKE_DIR"]
then
    CMAKE_DIR="$SRC/docker-cross-compiler/cmake"
fi

for ARCH in $ARCHS; do
    # Output directory.
    PREFIX=$DST/runtimes/$ARCH/native
    # Build directory.
    BUILD=$DST/out/$ARCH
    # Cmake toolchain file.
    TOOLCHAIN=$CMAKE_DIR/$ARCH.cmake

    # Create directories.
    mkdir -p $PREFIX $BUILD
    # Configure CMAKE.
    cmake -B $BUILD -S $SRC \
        -G Ninja \
        -DCMAKE_BUILD_TYPE=Release \
        -DCMAKE_INSTALL_PREFIX=$PREFIX \
        -DCMAKE_TOOLCHAIN_FILE=$TOOLCHAIN \
        $REFUEL_ADDITIONAL_CMAKE

    # Build and install.
    ninja -C $BUILD all
    
    if [ ! $NOINSTALL ]
    then
        ninja -C $BUILD install
    fi
done
