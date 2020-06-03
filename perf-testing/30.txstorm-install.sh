#!/usr/bin/env bash
cd $(dirname $0)
. ./00.params.sh
set -e

N=$((NODES-1))
cd ${SRC}/build/${NAME}

# copy files to servers
for i in `seq 0 $N`; do
    scp tx-storm* ${NAME}$i:/tmp/
done


# copy to work dir
for i in `seq 0 $N`; do
    ssh ${NAME}$i "sudo mv /tmp/tx-storm* /home/lachesis/ && sudo chown -R lachesis:lachesis /home/lachesis/tx-storm*"
done

# configure and run
for i in `seq 0 $N`; do
    ssh ${NAME}$i -f "sudo bash -c 'cd /home/lachesis; ./tx-storm --config=tx-storm.toml --num=$((i+1))/$((N+1)) &> tx-storm.log < /dev/null'"
done

