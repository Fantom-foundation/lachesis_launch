#!/usr/bin/env bash
cd $(dirname $0)
. ./00.params.sh
set -e

cd ${SRC}/build/${NAME}


# change service start script
for i in $@; do
    ssh ${NAME}$i "mkdir -p /tmp/lachesis"
    scp ./node$i/lachesis-node.service ${NAME}$i:/tmp/lachesis/
    ssh ${NAME}$i "sudo cp /tmp/lachesis/lachesis-node.service /home/lachesis/ && sudo chown -R lachesis:lachesis /home/lachesis"
    ssh ${NAME}$i "sudo systemctl daemon-reload && sudo systemctl restart lachesis-node"
done
