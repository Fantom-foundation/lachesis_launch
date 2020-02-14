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

# make network config
go run ../../cmd/lachesis --testnet --port 7946 --nodiscover --v5disc dumpconfig > network.toml
for i in `seq 0 $N`; do
    grep -v DataDir network.toml > node$i/network.toml
done
rm network.toml

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
ExecStart=/home/lachesis/lachesis --config ./network.toml --datadir=. --nousb --password ./validator.pswd --unlock ${ACC} --validator ${ACC} --nat="extip:${IP}"
OOMScoreAdjust=-900

[Install]
WantedBy=multi-user.target
Alias=lachesis.service

CFG
done

# copy files to servers
for i in `seq 0 $N`; do
    scp -r ./node$i ${NAME}$i:/tmp/lachesis
    scp -r ./lachesis ${NAME}$i:/tmp/lachesis/
done


# make dedicated user
for i in `seq 0 $N`; do
    ssh ${NAME}$i "sudo useradd lachesis && sudo mv /tmp/lachesis /home/lachesis && sudo chown -R lachesis:lachesis /home/lachesis"
done


# configure and run service
for i in `seq 0 $N`; do
    ssh ${NAME}$i "sudo ln -s /home/lachesis/lachesis-node.service /etc/systemd/system/lachesis-node.service && sudo systemctl daemon-reload && sudo systemctl start lachesis-node"
done
