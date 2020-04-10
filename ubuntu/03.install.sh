#!/usr/bin/env bash
cd $(dirname $0)
. ./00.params.sh
set -e

N=$((NODES-1))
cd ${SRC}/build/${NAME}

# check prev script 01.keygen.sh is done
for i in `seq 0 $N`; do
    if ! [ -d node$i/keystore ]
    then
	echo "No keys found. Run 01.keygen.sh first!"
	exit 1
    fi
done

if ! [ -f network.toml ]
then
    echo "No keys found. Run 02.network-config.sh first!"
    exit 1
fi


# copy files to servers
for i in `seq 0 $N`; do
    scp -r ./node$i ${NAME}$i:/tmp/lachesis
    scp ./lachesis ./network.toml ${NAME}$i:/tmp/lachesis/
done


# make dedicated user
for i in `seq 0 $N`; do
    ssh ${NAME}$i "sudo useradd lachesis && sudo mv /tmp/lachesis /home/lachesis && sudo chown -R lachesis:lachesis /home/lachesis"
done


# configure and run service
for i in `seq 0 $N`; do
    ssh ${NAME}$i "sudo ln -s /home/lachesis/lachesis-node.service /etc/systemd/system/lachesis-node.service && sudo systemctl daemon-reload && sudo systemctl start lachesis-node"
done
