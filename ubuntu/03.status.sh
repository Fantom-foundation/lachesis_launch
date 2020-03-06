#!/usr/bin/env bash
cd $(dirname $0)
. ./00.params.sh


N=$((NODES-1))

# print status
for i in `seq 0 $N`; do
    echo SERVER ${NAME}$i
    ssh ${NAME}$i "sudo systemctl status lachesis-node"
done
