#!/usr/bin/env bash
cd $(dirname $0)
set -e

NODE_API=http://localhost:18545
mkdir -p ./files


# Don't start often than period

PERIOD_SEC=$(( 30*60 ))
touch -d "${PERIOD_SEC} seconds ago" ./files/snapshot.inc
if
	AGE_SEC=$(( $(date +%s)-$(stat -c %Y ./files/snapshot.inc) ))
	[ ${AGE_SEC} -lt ${PERIOD_SEC} ]
then
    echo "Snapshot was updated recently. Wait then try again later."
    exit 1
fi


# Check for new epoch

current_epoch() {
    curl -X POST ${NODE_API} \
	-H 'Content-Type: application/json' \
	-d @- << JSON | jq --raw-output '.result' | while read EPOCH; do echo $(($EPOCH)); done
{"jsonrpc":"2.0",
 "method":"ftm_currentEpoch",
 "params":[],
 "id":1 }
JSON
}

EPOCH_WAS=$(cat files/was.epoch 2>/dev/null || echo 0)
EPOCH_NOW=$(current_epoch || echo 0)
if
    [ ${EPOCH_NOW} -le ${EPOCH_WAS} ]
then
    echo "There are no new epoch. Wait then try again later."
    exit 1
fi


# Export events:

export_events() {
    local F=$(echo "obase=16; $1" | bc)
    local T=$(echo "obase=16; $2" | bc)
    local O="$3"
    curl -X POST ${NODE_API} \
	-H 'Content-Type: application/json' \
	-d @- << JSON | jq --raw-output '.result' | while read EPOCH; do echo $(($EPOCH)); done
{"jsonrpc":"2.0",
 "method":"dag_exportEvents",
 "params":["0x$F", "0x$T", "$O"],
 "id":1 }
JSON
}

EPOCH_TO=$((EPOCH_NOW-1))
export_events ${EPOCH_WAS} ${EPOCH_TO} "$(readlink -f ./files)/snapshot.inc"

if [ -f ./files/snapshot.all ]
then
    # append prev file to the snapshot
    tail -c +9 ./files/snapshot.inc >> ./files/snapshot.all
else
    # snapshot file is the first
    cp ./files/snapshot.inc ./files/snapshot.all
fi
gzip --keep ./files/snapshot.all
mv ./files/snapshot.all.gz ./files/${EPOCH_NOW}.snapshot.gz
echo ${EPOCH_NOW} > files/was.epoch


# Update link to the latest snapshot file:

sed "s/{EPOCH}/${EPOCH_NOW}/g" index-template.html > ./files/index.html


# Remove snapshots except the 5 last:

ls -t1 ./files/*.snapshot.gz | tail -n +5 | while read F
do
    rm -f ${F}
done
