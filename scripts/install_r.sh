#!/bin/bash
set -e

source $(dirname $BASH_SOURCE)/config.sh

echo "Installing pcre2"
URL="https://downloads.sourceforge.net/pcre/pcre2-10.35.tar.bz2"
curl -sL $URL | tar xvj -C $SRC &&
    cd ${SRC}/pcre* &&
    ./configure \
        --prefix=$PREFIX \
        --enable-jit \
        --enable-unicode \
        --enable-pcre2-16 \
        --enable-pcre2-32 &&
    make --jobs=16 &&
    make install &&
    cd - &&
    rm -rf ${SRC}/pcre*

# Build with Intel MKL
# https://software.intel.com/content/www/us/en/develop/articles/using-intel-mkl-with-r.html
# Uncomment MKL_LIBRARY_PATH in scripts/config.sh to build with MKL support. MKL
# can increase math operations by ~2x, although the real benefits are often
# smaller since most packages dispatch heavy operations to C++ or Fortran DLLs.
# Not using here to limit dependencies.
if [ -n "$MKL_LIBRARY_PATH" ]; then
    echo "Building R with MKL"
    source /uufs/chpc.utah.edu/sys/installdir/intel/compilers_and_libraries_2019.5.281/linux/mkl/bin/mklvars.sh intel64
    MKL="-Wl,--no-as-needed -lmkl_gf_lp64 -Wl,--start-group -lmkl_gnu_thread  -lmkl_core  -Wl,--end-group -fopenmp  -ldl -lpthread -lm"
fi

echo "Installing R"
R_VERSION=4.0.3
R_PREFIX=${PREFIX}/R/${R_VERSION}
mkdir -p $R_PREFIX

URL="https://cran.rstudio.com/src/base/R-4/R-${R_VERSION}.tar.gz"
curl -sL $URL | tar xvz -C $SRC &&
    cd ${SRC}/R-${R_VERSION} &&
    ./configure \
        --prefix=$R_PREFIX \
        --enable-R-shlib \
        --with-blas="$MKL" \
        --with-lapack &&
    make --jobs=16 &&
    make install &&
    cd - &&
    rm -rf ${SRC}/R-${R_VERSION}

ln -s ${R_PREFIX}/bin/R ${BIN}/R
ln -s ${R_PREFIX}/bin/Rscript ${BIN}/Rscript

cp ${WD}/templates/Rprofile.site ${R_PREFIX}/lib64/R/etc/Rprofile.site
echo "Successfully installed R and dependencies"
