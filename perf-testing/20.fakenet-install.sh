#!/usr/bin/env bash
cd $(dirname $0)
. ./00.params.sh
set -e


N=$((NODES-1))
cd ${SRC}/build/${NAME}

# copy files to servers
for i in `seq 0 $N`; do
    scp -r ./node$i ${NAME}$i:/tmp/lachesis
    scp lachesis network.toml test_accs.json ${NAME}$i:/tmp/lachesis/
done


# make dedicated user
for i in `seq 0 $N`; do
    ssh ${NAME}$i "sudo useradd lachesis && sudo mv /tmp/lachesis /home/lachesis && sudo chown -R lachesis:lachesis /home/lachesis"
done


# configure and run service
for i in `seq 0 $N`; do
    ssh ${NAME}$i "sudo ln -s /home/lachesis/lachesis-node.service /etc/systemd/system/lachesis-node.service && sudo systemctl daemon-reload && sudo systemctl start lachesis-node"
done
