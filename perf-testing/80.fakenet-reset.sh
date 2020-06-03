#!/usr/bin/env bash
cd $(dirname $0)
. ./00.params.sh
set -e


N=$((NODES-1))
cd ${SRC}/build/${NAME}

for i in `seq 0 $N`; do
    echo SERVER ${NAME}$i
    ssh ${NAME}$i "sudo systemctl stop lachesis-node && cd /home/lachesis && sudo rm -fr *-ldb go-lachesis && sudo systemctl start lachesis-node"
done
