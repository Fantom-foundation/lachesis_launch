#!/usr/bin/env bash
cd $(dirname $0)
. ./00.params.sh


echo "
3. SFC functions work on A.
"

./local-node.sh ${vNEW} >/dev/null &
sleep 30

KEY_OBJECT=$(cat ${SRC}/build/${NAME}/sfc/UTC--*)
KEY_PASSWD=$(cat ${SRC}/build/${NAME}/sfc/sfc-admin.pswd)

pushd ${SFC}/integration_tests  > /dev/null
node testing.js -h "127.0.0.1" -p 18545 --payer --keyObject "${KEY_OBJECT}" --password "${KEY_PASSWD}"
popd  > /dev/null

./stop-local-node.sh

