#!/usr/bin/env bash
cd $(dirname $0)
. ./00.params.sh
set -e


echo "
------------------
B. During the node upgrade

1. Upgrade some nodes of the testnet
"
./versions.sh


echo "
2. Test that local nodes A, B can still sync
"
./local-node.sh ${vOLD} ${vOLD} &
sleep 100
./stop-local-node.sh
sleep 100
./stop-local-node.sh
