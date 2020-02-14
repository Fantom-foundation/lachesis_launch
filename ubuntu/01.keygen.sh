#!/usr/bin/env bash
cd $(dirname $0)
. ./00.params.sh
set -e

N=$((NODES-1))

# compile cmd/lachesis
make build

# temporary dir for keys and configs
mkdir build/${NAME}
mv build/lachesis build/${NAME}/
cd build/${NAME}
for i in `seq 0 $N`; do 
    mkdir node$i
done

# generate validator's keys
for i in `seq 0 $N`; do 
    echo myPswdN$i > node$i/validator.pswd && ./lachesis --datadir=node$i account new --password node$i/validator.pswd
done

# generate SFC-admin's key
echo 123456 > sfc-admin.pswd && ./lachesis --datadir=. account new --password sfc-admin.pswd && mv keystore sfc && mv sfc-admin.pswd sfc/


# note and exit
cat << NOTE

MANUAL OPERATION IS NEEDED: replace keys with generated keys in func TestGenesis()
    "vi ./lachesis/genesis/genesis.go"
Then run next step
    "./02.install.sh"

After installing you can avoid TestGenesis() changes
    "git checkout -- ./lachesis/genesis/genesis.go"

NOTE