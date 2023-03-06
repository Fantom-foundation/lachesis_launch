#!/bin/bash

#######################################
# Bash script to launch a read-only go-opera node
#######################################

VERSION='release/1.1.2-rc.5'
# Pick a genesis file for your network in ./genesis-files.md
GENESIS='mainnet-171200-pruned-mpt.g'
# snap or full (full by default)
SYNCMODE=full
# Substitute half of RAM capacity in MB (3600 by default). Affects performance.
CACHE=8000
# Substitute DB layout preset (ldb-1 by default). Affects performance. We recommend using pbl-1 for API nodes and ldb-1 otherwise.
DB=ldb-1

# Update and apt-get install build-essential
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get install -y build-essential git

# Install golang
wget https://go.dev/dl/go1.19.3.linux-amd64.tar.gz
sudo tar -xvf go1.19.3.linux-amd64.tar.gz -C /usr/local/

# Setup golang environment variables
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# Checkout and build go-opera
git clone https://github.com/Fantom-foundation/go-opera.git
cd go-opera/
git checkout $VERSION
make

# Download the genesis file
# Note: In a case of an upgrade from a previous node version,
# downloading new genesis file is not necessary. Skip this step and omit --genesis flag
cd build/
wget https://download.fantom.network/$GENESIS

# Start a read-only node to join the selected network
# --genesis and --db.preset flags are needed only for first launch
nohup ./opera --genesis $GENESIS --syncmode $SYNCMODE --cache $CACHE --db.preset $DB &
