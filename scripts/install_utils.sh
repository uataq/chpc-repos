#!/bin/bash
set -e

source $(dirname $BASH_SOURCE)/config.sh

install utils/* $BIN
