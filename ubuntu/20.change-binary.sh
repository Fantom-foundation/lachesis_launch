#!/usr/bin/env bash
cd $(dirname $0)
. ./00.params.sh
set -e

cd ${SRC}/build/${NAME}


# copy files to servers
for i in $@; do
    ssh ${NAME}$i "mkdir -p /tmp/lachesis"
    scp ./node$i/network.toml ${NAME}$i:/tmp/lachesis/
    scp ./lachesis ${NAME}$i:/tmp/lachesis/
done

# backup and replace
DT=$(date +"%Y-%m-%d")
for i in $@; do
    ssh ${NAME}$i "sudo systemctl stop lachesis-node"
    ssh ${NAME}$i "test -d /tmp/lachesis-${DT} || sudo cp -r /home/lachesis /tmp/lachesis-${DT}"
    ssh ${NAME}$i "sudo cp /tmp/lachesis/lachesis /tmp/lachesis/network.toml /home/lachesis/ && sudo chown -R lachesis:lachesis /home/lachesis"
    ssh ${NAME}$i "sudo systemctl start lachesis-node"
done
