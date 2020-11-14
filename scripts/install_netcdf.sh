#!/bin/bash
set -e

source $(dirname $BASH_SOURCE)/config.sh

echo "Installing zlib"
URL="https://zlib.net/zlib-1.2.11.tar.gz"
curl -sL $URL | tar xvz -C $SRC &&
        cd ${SRC}/zlib* &&
        ./configure --prefix=$PREFIX &&
        make --jobs=16 &&
        make install &&
        cd - &&
        rm -rf ${SRC}/zlib*

echo "Installing HDF5"
URL="https://support.hdfgroup.org/ftp/HDF5/releases/hdf5-1.12/hdf5-1.12.0/src/hdf5-1.12.0.tar.gz"
curl -sL $URL | tar xvz -C $SRC &&
        cd ${SRC}/hdf5* &&
        ./configure --enable-hl --prefix=$PREFIX &&
        make --jobs=16 &&
        make install &&
        cd - &&
        rm -rf ${SRC}/hdf5*

echo "Installing netcdf-c"
URL="https://github.com/Unidata/netcdf-c/archive/v4.7.4.tar.gz"
curl -sL $URL | tar xvz -C $SRC &&
        cd ${SRC}/netcdf-c* &&
        ./configure --prefix=$PREFIX --disable-dap &&
        make --jobs=16 &&
        make install &&
        cd - &&
        rm -rf ${SRC}/netcdf-c*

echo "Installing netcdf-fortran"
URL="https://github.com/Unidata/netcdf-fortran/archive/v4.5.3.tar.gz"
curl -sL $URL | tar xvz -C $SRC &&
        cd ${SRC}/netcdf-fortran* &&
        ./configure --prefix=$PREFIX &&
        make --jobs=16 &&
        make install &&
        cd - &&
        rm -rf ${SRC}/netcdf-fortran*

echo "Successfully installed NetCDF libraries and dependencies"
