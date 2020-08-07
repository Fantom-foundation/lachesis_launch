[Stop the node](#stop-the-node)  
[Update your environment](#update-your-environment)  
[Backup](#backup)  
[Checkout new version of go-lachesis](#checkout-new-version-of-go-lachesis)  
[Download new mainnet genesis](#download-new-mainnet-genesis)  
[Start up a read only server](#start-up-a-read-only-server)  
[Startup as a validator](#startup-as-a-validator)  

This document describes the steps to upgrade a validator running go-lachesis v0.6.0-rc2 (v0.6.0-rc3) to the version v0.7.0-rc1.

Validator Guides: [https://github.com/Fantom-foundation/go-lachesis/wiki/Validator-Guides](https://github.com/Fantom-foundation/go-lachesis/wiki/Validator-Guides)


### Stop the node

Make sure to stop the node first. Ensure the node will not get restarted before processing the next steps.

```shell script
killall lachesis
```

### Update your environment:

Update your environment

```shell script
sudo apt-get update
sudo apt-get -y upgrade
```

Assume build tools and golang version 13 or higher are installed.
If it's not done, check setup_validator.md file.

Setup golang environment variables

```shell script
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
```

### Backup

Make sure the node has already stopped.

Backup current datadir directory (copy the datadir directory). 
It includes the datadir/keystore (private keys) directory.

```shell script
cp -rf  .lachesis/ .lachesis_bk
```

Move go-lachesis source code to a backup directory

```shell script
mv /path/to/go-lachesis/ /path/to/go-lachesis-bk_v06
```

### Checkout new version of go-lachesis

```shell script
cd $HOME/go/src/github.com/Fantom-foundation/
git clone https://github.com/Fantom-foundation/go-lachesis.git
cd go-lachesis/
git checkout tags/v0.7.0-rc.1 -b lachesis-v7rc1
make build
```

Confirm your go-lachesis version

```shell script
./build/lachesis version
Go-Lachesis
Version: 0.7.0-rc.1
...
```

### Download new mainnet genesis

Download the default genesis mainnet.toml

```shell script
cd $HOME/go/src/github.com/Fantom-foundation/go-lachesis/build
wget https://raw.githubusercontent.com/Fantom-foundation/lachesis_launch/master/releases/v0.7.0-rc.1/mainnet.toml .
```

### Start up a read only server

```shell script
./lachesis --config mainnet.toml --nousb --rpc --rpcaddr=0.0.0.0 --rpcport=3001 --rpcvhosts=* --rpccorsdomain=* --rpcapi=eth,debug,admin,web3,personal,net,txpool,ftm,sfc --ws --wsaddr=0.0.0.0 --wsport=3500 --wsorigins=* --wsapi=eth,debug,admin,web3,personal,net,txpool,ftm,sfc --verbosity 4
```

Attach to the node

```shell script
./lachesis attach
```

Ensure node has synced up.

Validator Guides:[https://github.com/Fantom-foundation/go-lachesis/wiki/Validator-Guides](https://github.com/Fantom-foundation/go-lachesis/wiki/Validator-Guides)


### Startup as a validator

The node should be synced before launching the validator.

Stop your current lachesis process.

```shell script
killall lachesis
```

Start the validator node

```shell script
./lachesis --config mainnet.toml --nousb --validator 0xADDRESS --unlock 0xADDRESS --password /path/to/password
```


### Checks via the console

Transferring funds using the console

```shell script
./lachesis attach
```

```js
var tx = {from: "0xSENDER", to: "0xRECEIVER", value: web3.toWei("1000", "ftm")}
personal.sendTransaction(tx, "password")
```

Interact with SFC using the console.

Use the ABI of the release `2.0.2-rc1` located at `./releases/sfc-abi-2.0.2-rc1.json`.

```js
// Init SFC contract context
abi = PASTE_ABI_HERE
sfc.contract = web3.ftm.contract(abi).at("0xfc00face00000000000000000000000000000000")

// Sanity check
sfc.contract.stakersNum() // if everything is all right, will return non-zero value
```
