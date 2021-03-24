[Stop the node](#stop-the-node)
[Update your environment](#update-your-environment)
[Backup](#backup)
[Checkout new version of go-lachesis](#checkout-new-version-of-go-lachesis)
[Start up a read only server](#start-up-a-read-only-server)
[Startup as a validator](#startup-as-a-validator)

This document describes the steps to upgrade a node running go-lachesis v0.7.0-rc1 (v0.7.0-rc2) to the version v1.0.0-rc0.

Validator Guides: [https://github.com/Fantom-foundation/go-lachesis/wiki/Validator-Guides](https://github.com/Fantom-foundation/go-lachesis/wiki/Validator-Guides)

### Stop the node

Make sure to stop the node first and that the node is not restarted before processing the next steps.

```
killall lachesis
```

### Update your environment:

Update your environment

```
sudo apt-get update
sudo apt-get -y upgrade
```

Assume build tools and golang version 14 or higher are installed.
If it's not done, check setup_validator.md file.

Setup golang environment variables

```
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
```

### Backup

Make sure the node has already stopped.

Backup current datadir directory (copy the datadir directory). 
It includes the datadir/keystore (private keys) directory.

```
cp -rf  .lachesis/ .lachesis_bk_07rc1
```

### Checkout new version of go-lachesis

```
cd $HOME/go/src/github.com/Fantom-foundation/
git clone https://github.com/Fantom-foundation/go-lachesis.git
cd go-lachesis/
git fetch origin
git checkout release/1.0.0-rc.0
make build
```

Confirm your go-lachesis version

```
./build/lachesis version
Go-Lachesis
Version: 1.0.0-rc.0
...
```

### Start up a read only server

```
lachesis --nousb
```

Attach to the node

```
lachesis attach
```

Ensure node has synced up.

Validator Guides: [https://github.com/Fantom-foundation/go-lachesis/wiki/Validator-Guides](https://github.com/Fantom-foundation/go-lachesis/wiki/Validator-Guides)


### Startup as a validator

The node should be synced before launching the validator.

Stop your current lachesis process.

```
killall lachesis
```

Start the validator node

```
lachesis --nousb --validator 0xAddress --unlock 0xAddress --password /path/to/password
```


### Checks via the console

Transferring funds using the console

```
lachesis attach
```

```
var tx = {from: "0xSENDER", to: "0xRECEIVER", value: web3.toWei("1000", "ftm")}
personal.sendTransaction(tx, "password")
```

Interact with SFC using the console.

The current sfc release is `2.0.4-rc2`. The ABI output available at `./releases/sfc-abi-2.0.4-rc.2.json`.

```js
// Init SFC contract context
abi = JSON.parse('...')
// Note: define variable sfcc (instead of sfc) to avoid clashing with the sfc namespace introduced in go-lachesis v0.7.0-rc1.
sfcc = web3.ftm.contract(abi).at("0xfc00face00000000000000000000000000000000")

// Sanity check
sfcc.stakersNum() // if everything is all right, will return a non-zero value
