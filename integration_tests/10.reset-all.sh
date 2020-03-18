#!/usr/bin/env bash
cd $(dirname $0)
. ./00.params.sh
set -e

N=$((NODES-1))
TAG=${vOLD}


./compile.sh ${TAG}

# copy files to servers
for i in `seq 0 $N`; do
    ssh ${NAME}$i "mkdir -p /tmp/lachesis"
    rsync ./bin/*-${TAG} ${NAME}$i:/tmp/lachesis/
done

# and replace
for i in `seq 0 $N`; do
    ssh ${NAME}$i "sudo systemctl stop lachesis-node"
    ssh ${NAME}$i "sudo rm -fr /home/lachesis/*-ldb &&
	    sudo cp /tmp/lachesis/lachesis-${TAG} /home/lachesis/lachesis &&
	    sudo cp /tmp/lachesis/network.toml-${TAG} /home/lachesis/network.toml &&
	    sudo chown -R lachesis:lachesis /home/lachesis
	    sudo systemctl start lachesis-node"
done

