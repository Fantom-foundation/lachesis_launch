[Stop the node](#stop-the-node)  
[Update your environment](#update-your-environment)  
[Backup](#backup)  
[Checkout new version of go-lachesis](#checkout-new-version-of-go-lachesis)  
[Download new mainnet genesis](#download-new-mainnet-genesis)  
[Start up a read only server](#start-up-a-read-only-server)  
[Startup as a validator](#startup-as-a-validator)  
Checks via the console
 

This document describes the steps to upgrade a validator running go-lachesis v0.5.0-rc1 (v0.5.0-rc2) to latest version v0.6.0-rc2.

Validator Guides: [https://github.com/Fantom-foundation/go-lachesis/wiki/Validator-Guides](https://github.com/Fantom-foundation/go-lachesis/wiki/Validator-Guides)


### Stop the node

Make sure to stop the node first and the node is not restarted before processing the next steps.

```
killall lachesis
```

### Update your environment:

Update your environment

```
sudo apt-get update
sudo apt-get -y upgrade
```

Assume build tools and golang version 13 or higher are installed.
If it's not done, check setup_validator.md file.

Setup golang environment variables

```
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
```

### Backup

Make sure the node is already stopped.

Backup current datadir directory (copy the datadir directory). 
You can copy keystore directory, and /path/to/datadir/*-ldb folders.

```
cd
cp -rf  .lachesis/ .lachesis_bk
```


Backup go-lachesis folder

```
cd $HOME/go/src/github.com/Fantom-foundation/
mv go-lachesis go-lachesis-bk_v05
```


### Checkout new version of go-lachesis

```
cd $HOME/go/src/github.com/Fantom-foundation/
git clone https://github.com/Fantom-foundation/go-lachesis.git
cd go-lachesis/
git checkout tags/v0.6.0-rc.2 -b lachesis-v06rc2
make build
```

Confirm your go-lachesis version

```
./build/lachesis help

VERSION:
   0.6.0-rc.2
COMMANDS:
   account                            Manage accounts
   attach                             Start an interactive JavaScript environment (connect to node)
   console                            Start an interactive JavaScript environment
   dumpconfig                         Show configuration values
   js                                 Execute the specified JavaScript files
   license                            Display license information
   version                            Print version numbers
   wallet                             Manage Ethereum presale wallets
   help                               Shows a list of commands or help for one command
```

### Download new mainnet genesis

Download the default genesis mainnet.toml

```shell script
cd $HOME/go/src/github.com/Fantom-foundation/go-lachesis/build
wget https://raw.githubusercontent.com/Fantom-foundation/lachesis_launch/master/releases/v0.6.0/mainnet.toml .
```

### Start up a read only server

```
./lachesis --config mainnet.toml --nousb --rpc --rpcaddr=0.0.0.0 --rpcport=3001 --rpcvhosts=* --rpccorsdomain=* --rpcapi=eth,debug,admin,web3,personal,net,txpool,ftm,sfc --ws --wsaddr=0.0.0.0 --wsport=3500 --wsorigins=* --wsapi=eth,debug,admin,web3,personal,net,txpool,ftm,sfc --verbosity 4
```

Attach to the node

```
./lachesis attach
```

Ensure node has synced up.

Validator Guides:[https://github.com/Fantom-foundation/go-lachesis/wiki/Validator-Guides](https://github.com/Fantom-foundation/go-lachesis/wiki/Validator-Guides)


### Startup as a validator

Now the non-validator node is synced.
Stop your current lachesis process.

```
killall lachesis
```

Start the validator node

```
./lachesis --config mainnet.toml --nousb --validator 0x --unlock 0x --password /path/to/password
```

If you need to disable the node check for the latest version, add `--nocheckversion` to the command line.


### Checks via the console

Transfering funds via the console

```
./lachesis attach
```

```
var tx = {from: "0x", to: "0x", value: web3.toWei(4000000, "ether")}
personal.sendTransaction(tx, "password")
```

Interact with SFC via the console. Use the ABI output of the latest release `1.1.0-rc1` located at `./releases/sfc-abi-1.1.json`.

```
// Init SFC contract context
abi = JSON.parse('...')
sfc = web3.ftm.contract(abi).at("0xfc00face00000000000000000000000000000000")

// Sanity check
sfc.stakers(1) // if everything is allright, will return non-zero values

// Use sfc checks

```

