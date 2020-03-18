#!/usr/bin/env bash
cd $(dirname $0)
set -e

DROP=
if [ "$1" == "fromscratch" ]; then
    shift
    DROP=true
fi

N=0
for TAG in $@; do
    echo "local node#$N ${TAG}:"
    echo "(run ./stop-local-node.sh when enough)"
    ./compile.sh ${TAG}

    DATADIR=/tmp/testnode$N
    RPCPORT=$((18545+N))
    N=$((N+1))

    if [ $DROP ]; then
        rm -fr ${DATADIR}
    fi

    ./bin/lachesis-${TAG} --nousb --config=./bin/network.toml-${TAG} --datadir "${DATADIR}" --rpc --rpcport=${RPCPORT} --rpcapi="eth,debug,admin,web3,personal,net,txpool,ftm,sfc" 2>&1

done
