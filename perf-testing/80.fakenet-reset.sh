#!/usr/bin/env bash
cd $(dirname $0)
. ./00.params.sh
set -e


N=$((NODES-1))
cd ${SRC}/build/${NAME}

for i in `seq 0 $N`; do
    echo SERVER ${NAME}$i STOP
    ssh ${NAME}$i "sudo systemctl stop lachesis-node"
done


for i in `seq 0 $N`; do
    echo SERVER ${NAME}$i START
    scp network.toml ${NAME}$i:/tmp/
    ssh ${NAME}$i "sudo mv /tmp/network.toml /home/lachesis/ && sudo chown -R lachesis:lachesis /home/lachesis/network.toml"
    ssh ${NAME}$i "cd /home/lachesis && sudo rm -fr *-ldb go-lachesis && sudo systemctl start lachesis-node"
done
