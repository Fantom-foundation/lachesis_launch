#!/usr/bin/env bash
cd $(dirname $0)
. ./00.params.sh


N=$((NODES-1))

for i in `seq 0 $N`; do
    echo SERVER ${NAME}$i
    ssh ${NAME}$i "
sudo systemctl stop lachesis-node
sudo rm /etc/systemd/system/lachesis-node.service
sudo systemctl daemon-reload
sudo rm -fr /home/lachesis
sudo userdel lachesis
"
done
