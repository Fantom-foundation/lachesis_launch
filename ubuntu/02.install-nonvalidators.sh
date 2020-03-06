#!/usr/bin/env bash
cd $(dirname $0)
. ./00.params.sh
set -e

N=$((NODES-1))
cd ${SRC}/build/${NAME}

# check prev script 01.keygen.sh is done
if ! [ -f ./lachesis ]
then
    echo "No binary found. Run 01.keygen.sh first!"
    exit 1
fi


# make service config
for i in `seq 0 $N`; do
    IP=$(ssh -G ${NAME}$i | grep "^hostname" | awk '{print $2}')
    mkdir -p node$i
    cat << CFG > node$i/lachesis-node.service
[Unit]
Description=Lachesis node
After=network.target auditd.service

[Service]
Type=simple
User=lachesis
Group=lachesis
WorkingDirectory=/home/lachesis
ExecStart=/home/lachesis/lachesis --datadir=. --nousb --nat="extip:${IP}" --rpc --rpcaddr=0.0.0.0 --rpcport=3001 --rpcvhosts=* --rpccorsdomain=* --rpcapi=eth,debug,web3,net,txpool,ftm,sfc --ws --wsaddr=0.0.0.0 --wsport=3500 --wsorigins=* --wsapi=eth,debug,web3,net,txpool,ftm,sfc
OOMScoreAdjust=-900

[Install]
WantedBy=multi-user.target
Alias=lachesis.service

CFG
done


# copy files to servers
for i in `seq 0 $N`; do
    scp -r ./node$i ${NAME}$i:/tmp/lachesis
    scp ./lachesis ${NAME}$i:/tmp/lachesis/
done


# make dedicated user
for i in `seq 0 $N`; do
    ssh ${NAME}$i "sudo useradd lachesis && sudo mv /tmp/lachesis /home/lachesis && sudo chown -R lachesis:lachesis /home/lachesis"
done


# configure and run service
for i in `seq 0 $N`; do
    ssh ${NAME}$i "sudo ln -s /home/lachesis/lachesis-node.service /etc/systemd/system/lachesis-node.service && sudo systemctl daemon-reload && sudo systemctl start lachesis-node"
done
