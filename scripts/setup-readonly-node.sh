#!/bin/bash

#######################################
# Bash script to launch a read-only lachesis node
#######################################

LACHESIS_VERSION='1.0.0-rc.0'

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

# Checkout and build go-lachesis
mkdir -p $HOME/go/src/github.com/Fantom-foundation
cd $HOME/go/src/github.com/Fantom-foundation/
git clone https://github.com/Fantom-foundation/go-lachesis.git
cd go-lachesis/
git checkout release/$LACHESIS_VERSION
make build

# Start a read-only node to join the public mainnet
cd $HOME/go/src/github.com/Fantom-foundation/go-lachesis/build/
nohup ./lachesis --nousb &
