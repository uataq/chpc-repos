#!/bin/bash
set -e

WD=$(dirname ${HOME})/lin-group12/software

PREFIX=${WD}/local
SRC=${WD}/src

BIN=${PREFIX}/bin
INCLUDE=${PREFIX}/include
LIB=${PREFIX}/lib
PKGCONFIG=${LIB}/pkgconfig
SHARE=${PREFIX}/share

# Uncomment to build R with MKL
# MKL_LIBRARY_PATH="/uufs/chpc.utah.edu/sys/installdir/intel/compilers_and_libraries_2019.5.281/linux/tbb/lib/intel64_lin/gcc4.7:/uufs/chpc.utah.edu/sys/installdir/intel/compilers_and_libraries_2019.5.281/linux/compiler/lib/intel64_lin:/uufs/chpc.utah.edu/sys/installdir/intel/compilers_and_libraries_2019.5.281/linux/mkl/lib/intel64_lin:"

cd $WD
mkdir -p $PREFIX $SRC
mkdir -p $BIN $INCLUDE $LIB $SHARE

export PATH="${BIN}:${PATH}"
export CPPFLAGS="-I${INCLUDE}"
export LDFLAGS="-L${LIB}"
