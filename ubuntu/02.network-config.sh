#!/usr/bin/env bash
cd $(dirname $0)
. ./00.params.sh
set -e

N=$((NODES-1))
cd ${SRC}/build/${NAME}

# make network config
go run ../../cmd/lachesis --testnet --port 7946 --nodiscover --v5disc dumpconfig | grep -v DataDir > network.toml

# make service config
for i in `seq 0 $N`; do
    ACC=0x$(jq -r .address node$i/keystore/UTC--*)
    IP=$(ssh -G ${NAME}$i | grep "^hostname" | awk '{print $2}')
    cat << CFG > node$i/lachesis-node.service
[Unit]
Description=Lachesis validator node
After=network.target auditd.service

[Service]
Type=simple
User=lachesis
Group=lachesis
WorkingDirectory=/home/lachesis
ExecStart=/home/lachesis/lachesis --config ./network.toml --datadir=. --nousb --password ./validator.pswd --allow-insecure-unlock --unlock ${ACC} --validator ${ACC} --nat="extip:${IP}"
OOMScoreAdjust=-900

[Install]
WantedBy=multi-user.target
Alias=lachesis.service

CFG
done


# note and exit
cat << NOTE

Configs network.toml and node<N>/lachesis-node.service
    are generated in ${SRC}/build/${NAME}

Run next step
    "./03.install.sh"

NOTE