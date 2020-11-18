#!/bin/bash

CONFIG_FILENAME=$(realpath $BASH_SOURCE)
CONFIG_DIRNAME=$(dirname $CONFIG_FILENAME)
WD=$(realpath ${CONFIG_DIRNAME}/..)

PREFIX=${WD}/local
SRC=${WD}/src

BIN=${PREFIX}/bin
INCLUDE=${PREFIX}/include
LIB=${PREFIX}/lib
PKGCONFIG=${LIB}/pkgconfig
SHARE=${PREFIX}/share

# Uncomment to build R with MKL
# MKL_LIBRARY_PATH="/uufs/chpc.utah.edu/sys/installdir/intel/compilers_and_libraries_2019.5.281/linux/tbb/lib/intel64_lin/gcc4.7:/uufs/chpc.utah.edu/sys/installdir/intel/compilers_and_libraries_2019.5.281/linux/compiler/lib/intel64_lin:/uufs/chpc.utah.edu/sys/installdir/intel/compilers_and_libraries_2019.5.281/linux/mkl/lib/intel64_lin:"

mkdir -p $PREFIX $SRC
mkdir -p $BIN $INCLUDE $LIB $SHARE

export PATH="${BIN}:${PATH}"
export CPATH="${INCLUDE}:$CPATH"
export CPPFLAGS="-I${INCLUDE} $CPPFLAGS"
export LDFLAGS="-L${LIB} $LDFLAGS"
export LD_LIBRARY_PATH="${LIB}:$LD_LIBRARY_PATH"
export PKG_CONFIG_PATH="${PKGCONFIG}:$PKG_CONFIG_PATH"
export PROJ_LIB="${SHARE}/proj"

