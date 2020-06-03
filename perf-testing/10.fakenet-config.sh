#!/usr/bin/env bash
cd $(dirname $0)
. ./00.params.sh
set -e

# configs
cp ./cfg/*.* ${SRC}/build/${NAME}/

N=$((NODES-1))
cd ${SRC}/build/${NAME}
# make service config
for i in `seq 0 $N`; do
    IP=$(ssh -G ${NAME}$i | grep "^hostname" | awk '{print $2}')
    mkdir -p node$i
    cat << CFG > node$i/lachesis-node.service
[Unit]
Description=Lachesis validator node
After=network.target auditd.service

[Service]
Type=simple
User=lachesis
Group=lachesis
WorkingDirectory=/home/lachesis
ExecStart=/home/lachesis/lachesis --fakenet=$((i+1))/$((N+1)),test_accs.json --config ./network.toml --datadir=. --nousb \
    --nat="extip:${IP}" \
    --ws --wsaddr="127.0.0.1" --wsport=4500 --wsorigins="*" --wsapi="eth,debug,admin,web3,personal,txpool,ftm,sfc"
OOMScoreAdjust=-900

[Install]
WantedBy=multi-user.target
Alias=lachesis.service

CFG
done


# note and exit
cat << NOTE

Configs 'network.toml', 'tx-storm.toml' and 'node<N>/lachesis-node.service'
    are generated in ${SRC}/build/${NAME}

Put 'lachesis' and 'tx-storm' binaries into ${SRC}/build/${NAME}/, then
run next step
    './20.fakenet-install.sh'

NOTE