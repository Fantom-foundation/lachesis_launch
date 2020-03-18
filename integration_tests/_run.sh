#!/usr/bin/env bash
cd $(dirname $0)
set -e

( echo START
 ./10.reset-all.sh &&
 ./11.test-sync.sh &&
 ./20.upgrade-some.sh &&
 ./21.test-sync.sh &&
 ./30.upgrade-rest.sh &&
 ./31.test-sync.sh &&
 ./32.test-sfc.sh &&
 ./33.test-sync.sh &&
 echo FINISH OK ) | tee test.log
