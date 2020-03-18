#!/usr/bin/env bash
cd $(dirname $0)
. ./00.params.sh


for TAG in ${vOLD} ${vNEW}; do
    killall lachesis-${TAG}
done

sleep 4