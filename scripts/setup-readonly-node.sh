#!/bin/bash

#######################################
# Bash script to launch a read-only go-opera node
#######################################

VERSION='1.0.0-rc.1'

# Update and apt-get install build-essential
sudo apt-get update
sudo apt-get -y upgrade
sudo apt-get install -y build-essential

# Install golang
wget https://dl.google.com/go/go1.15.10.linux-amd64.tar.gz
sudo tar -xvf go1.15.10.linux-amd64.tar.gz
sudo mv go /usr/local

# Setup golang environment variables
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH

# Checkout and build go-opera
git clone https://github.com/Fantom-foundation/go-opera.git
cd go-opera/
git checkout release/$VERSION
make build

# Download genesis file
cd build/
# TODO add genesis file link after the launch

# Start a read-only node to join the public mainnet
nohup ./opera --genesis mainnet.g --nousb &
