#!/usr/bin/env bash
cd $(dirname $0)
. ./00.params.sh
set -e


N=$((NODES-1))

for i in `seq 0 $N`; do
    echo SERVER ${NAME}$i
    ssh ${NAME}$i -f "sudo bash -c 'cd /home/lachesis; sudo rm -f tx-storm.log; ./tx-storm --config=tx-storm.toml --num=$((i+1))/$((N+1)) &> tx-storm.log < /dev/null'"
done

