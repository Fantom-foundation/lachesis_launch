#!/bin/bash

#######################################
# Bash script to launch a read-only go-opera node
#######################################

VERSION='release/1.1.1-rc.1'
# Pick a genesis file for your network in ./genesis-files.md
GENESIS='mainnet-109331-pruned-mpt.g'
# snap or full
SYNCMODE=full

# Update and apt-get install build-essential
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get install -y build-essential

# Install golang
wget https://go.dev/dl/go1.18.2.linux-amd64.tar.gz
sudo tar -xvf go1.18.2.linux-amd64.tar.gz -C /usr/local/

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
# Substitute amount of available RAM for best performance
# --genesis flag is mandatory for first launch and optional otherwise
nohup ./opera --genesis $GENESIS --syncmode $SYNCMODE --cache 4000 &
