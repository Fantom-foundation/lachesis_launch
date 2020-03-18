#!/usr/bin/env bash
cd $(dirname $0)
. ./00.params.sh
set -e


echo "
3. Upgrade the rest of the testnet nodes

"
./versions.sh


echo "
---------------------------
C. Node upgrade is complete

1. Test that local nodes A, B can still sync.
"
./local-node.sh ${vOLD} ${vOLD} &
sleep 100
./stop-local-node.sh
sleep 100
./stop-local-node.sh


echo "
2. Do node upgrade for A. Then A can still sync
"
./local-node.sh ${vNEW} &
sleep 100
./stop-local-node.sh
