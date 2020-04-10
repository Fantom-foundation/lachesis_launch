#!/usr/bin/env bash
cd $(dirname $0)
. ./00.params.sh


echo "
------------------
A. Test before node upgrade
"
./versions.sh


echo "
1. Create new local nodes A, B

2. Test that A, B can sync with the testnet
"
./local-node.sh fromscratch ${vOLD} ${vOLD} &
sleep 100
./stop-local-node.sh
sleep 100
./stop-local-node.sh

