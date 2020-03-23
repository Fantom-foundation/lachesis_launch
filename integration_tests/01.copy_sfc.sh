#!/usr/bin/env bash
cd $(dirname $0)
. ./00.params.sh
set -e

mv $(find $SRC/build/*/sfc/ -type f -name "UTC--*" | head -1) ./bin/
mv $(find $SRC/build/*/sfc/ -type f -regex '^.*\.pswd'| head -1) ./bin/
