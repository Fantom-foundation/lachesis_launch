#!/usr/bin/env bash
cd $(dirname $0)
. ./00.params.sh


echo "
1. Test that A, B can still sync.
"
./local-node.sh fromscratch ${vNEW} ${vNEW} &
sleep 100
./stop-local-node.sh
sleep 100
./stop-local-node.sh

