#!/bin/bash
set -e

bash $(dirname $BASH_SOURCE)/install_netcdf.sh
bash $(dirname $BASH_SOURCE)/install_gdal.sh
bash $(dirname $BASH_SOURCE)/install_r.sh
bash $(dirname $BASH_SOURCE)/install_utils.sh
