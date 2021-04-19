[Stop the node](#stop-the-node)  
[Update your environment](#update-your-environment)  
[Backup](#backup)  
[Checkout new version of go-lachesis](#checkout-new-version-of-go-lachesis) 
[Start up a read only server](#start-in-read-mode)  
[Startup as a validator](#start-in-validator-mode)  

This document describes the steps to upgrade a validator running go-lachesis v0.7.0-rc1 to the version v1.0.0-rc0.

Validator Guides: [https://github.com/Fantom-foundation/go-lachesis/wiki/Validator-Guides](https://github.com/Fantom-foundation/go-lachesis/wiki/Validator-Guides)


### Stop the node

Make sure to stop the node before processing the next steps.

```
killall lachesis
```

### Update your environment:

Update your environment

```
sudo apt-get update
sudo apt-get -y upgrade
```

Upgrade golang

```
mkdir ~/temp
cd ~/temp
sudo rm -rf /usr/local/go/
wget https://dl.google.com/go/go1.15.10.linux-amd64.tar.gz
sudo tar -xvf go1.15.10.linux-amd64.tar.gz
sudo mv go /usr/local
```

Setup golang environment variables

```
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
```

### Backup

Make sure the node has already stopped.

Backup current datadir directory:

```
cp -rf  ~/.lachesis/ ~/.lachesis_bk_07rc1
```

Backup go-lachesis folder

```
cd $HOME/go/src/github.com/Fantom-foundation/
mv go-lachesis go-lachesis-bk_v07rc1
```

### Checkout new version of go-lachesis

```
git clone https://github.com/Fantom-foundation/go-lachesis.git
cd go-lachesis/
git checkout release/1.0.0-rc.0
make build
cd build
```

Confirm your go-lachesis version

```
./lachesis version
Version: 1.0.0-rc.0
```

### Start in read mode

```
nohup ./lachesis --nousb &
```

Attach to the node

```
./lachesis attach
```

### Start in validator mode

The node should be synced up before launching in validator mode.

Stop your current lachesis process.

```
killall lachesis
```

Start node in validator mode

```
nohup ./lachesis --nousb --validator 0x --unlock 0x --password /path/to/password  &
```


### Checks via the console

Transferring funds using the console

```
./lachesis attach
```

```
var tx = {from: "0xSENDER", to: "0xRECEIVER", value: web3.toWei("1000", "ftm")}
personal.sendTransaction(tx, "password")
```

Interact with SFC using the console, using [SFC 2.0.4-rc2 ABI](../sfc-abi-2.0.4-rc.2.json).

```
// Init SFC contract context
abi = JSON.parse('...')
// Note: define variable sfcc (instead of sfc) to avoid clashing with the sfc namespace introduced in go-lachesis v0.7.0-rc1.
sfcc = web3.ftm.contract(abi).at("0xfc00face00000000000000000000000000000000")

// Sanity check
sfcc.stakersNum() // if everything is all right, will return non-zero value