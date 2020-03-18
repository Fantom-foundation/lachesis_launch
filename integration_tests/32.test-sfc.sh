#!/usr/bin/env bash
cd $(dirname $0)
. ./00.params.sh


echo "
3. SFC functions work on A.
"

./local-node.sh ${vNEW} >/dev/null &
sleep 30

pushd ${SFC}  > /dev/null
node testing.js -h "127.0.0.1" -p 18545 --payer
popd  > /dev/null

./stop-local-node.sh

