#!/bin/bash
set -e

source $(dirname $BASH_SOURCE)/config.sh

echo "Installing sqlite3"
URL="https://www.sqlite.org/snapshot/sqlite-snapshot-202011020040.tar.gz"
curl -sL $URL | tar xvz -C $SRC &&
    cd ${SRC}/sqlite* &&
    ./configure --prefix=$PREFIX &&
    make --jobs=16 &&
    make install &&
    cd - &&
    rm -rf ${SRC}/sqlite*

echo "Installing proj"
URL="https://download.osgeo.org/proj/proj-7.2.0.tar.gz"
curl -sL $URL | tar xvz -C $SRC &&
    cd ${SRC}/proj* &&
    ./configure --prefix=$PREFIX &&
    make --jobs=16 &&
    make install &&
    cd - &&
    rm -rf ${SRC}/proj*

echo "Installing gdal"
URL="https://github.com/OSGeo/gdal/releases/download/v3.2.0/gdal-3.2.0.tar.gz"
curl -sL $URL | tar xvz -C $SRC &&
    cd ${SRC}/gdal* &&
    ./configure \
        --prefix=$PREFIX \
        --with-proj=$PREFIX \
        --with-geotiff=internal \
        --with-jpeg=internal \
        --with-libtiff=internal \
        --with-png=internal \
        --with-libjson-c=internal \
        --with-sfcgal=no &&
    make --jobs=16 &&
    make install &&
    cd - &&
    rm -rf ${SRC}/gdal*

echo "Successfully installed gdal and dependencies"
