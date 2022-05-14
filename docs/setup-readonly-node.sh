#!/bin/bash

#######################################
# Bash script to launch a read-only go-opera node
#######################################

VERSION='feature/customizable-genesis-file'
# Pick a genesis file for your network in ./genesis-files.md
GENESIS='mainnet-109331-no-mpt.g'
# snap or full
SYNCMODE=snap

# Update and apt-get install build-essential
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get install -y build-essential

# Install golang
wget https://dl.google.com/go/go1.15.10.linux-amd64.tar.gz
sudo tar -xvf go1.15.10.linux-amd64.tar.gz -C /usr/local/

# Setup golang environment variables
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# Checkout and build go-opera
git clone https://github.com/uprendis/go-opera.git
cd go-opera/
git checkout $VERSION
make

# Download the genesis file
cd build/
wget https://opera.fantom.network/$GENESIS

# Start a read-only node to join the selected network
# Substitute amount of available RAM for best performance
nohup ./opera --genesis $GENESIS --syncmode $SYNCMODE --cache 4000 &
