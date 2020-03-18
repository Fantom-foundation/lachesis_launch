#!/usr/bin/env bash
cd $(dirname $0)
. ./00.params.sh
set -e

TAG=$1

mkdir -p ./bin
if [ ! -f ./bin/lachesis-${TAG} ]; then
    pushd ${SRC}
    git checkout ${TAG}
    make build
    popd
    mv ${SRC}/build/lachesis ./bin/lachesis-${TAG}
fi
