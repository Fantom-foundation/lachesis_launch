#!/usr/bin/env bash
cd $(dirname $0)
. ./00.params.sh


echo "
3. SFC functions work on A.
"

./local-node.sh ${vNEW} >/dev/null &
sleep 30

keyFile=$(find ./bin -type f -name "UTC--*" | head -1)
kObject=$(less -FX $keyFile)
if [ -z $PASSWORD ]
then
  PASSWORD=$(less -FX $(find ./bin -type f -regex '^.*\.pswd' | head -1))
fi

pushd ${SFC}/integration_tests  > /dev/null
node testing.js -h "127.0.0.1" -p 18545 --payer --keyObject "$kObject" --password "$PASSWORD"
popd  > /dev/null

./stop-local-node.sh

