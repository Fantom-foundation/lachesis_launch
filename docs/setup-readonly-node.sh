#!/bin/bash

#######################################
# Bash script to launch a read-only go-opera node
#######################################

VERSION='release/1.1.0-rc.4'
# Pick a file for your network
# The file for mainnet is mainnet.g
# File file for public testnet is testnet.g
NETWORK='mainnet.g'

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
git clone https://github.com/Fantom-foundation/go-opera.git
cd go-opera/
git checkout $VERSION
make

# Download the genesis file
cd build/
wget https://opera.fantom.network/$NETWORK

# Start a read-only node to join the selected network
nohup ./opera --genesis $NETWORK &
