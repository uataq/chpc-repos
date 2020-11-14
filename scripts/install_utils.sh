#!/bin/bash
set -e

source $(dirname $BASH_SOURCE)/config.sh

# cp -r utils/* $BIN
# chmod +x utils/*
install utils/* $BIN
