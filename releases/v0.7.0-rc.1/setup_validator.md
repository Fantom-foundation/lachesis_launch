[Installing build tools](#installing-build-tools)  
[Install golang](#install-golang)  
[Installing go-lachesis](#installing-go-lachesis)  
[Installing the Special Fee Contract](#installing-the-special-fee-contract)  
[Setup mainnet genesis](#setup-mainnet-genesis) 
[Creating a validator on the SFC](#create-a-validator-on-the-sfc)  
[Start up a read only server](#start-up-a-read-only-server)  
[Startup as a validator](#startup-as-a-validator)
Transferring tokens from ERC20 or BEP2 to mainnet

This document shows the steps to set up a validator using the version v0.7.0-rc1.

Validator Guides:[https://github.com/Fantom-foundation/go-lachesis/wiki/Validator-Guides](https://github.com/Fantom-foundation/go-lachesis/wiki/Validator-Guides)

### Installing build tools

To install go-lachesis you will need golang version 13 or higher and make

Update your environment

```
sudo apt-get update
sudo apt-get -y upgrade
```

Install build-essential to install make

```
sudo apt-get install -y build-essential
```

### Install golang

```
wget https://dl.google.com/go/go1.13.3.linux-amd64.tar.gz
sudo tar -xvf go1.13.3.linux-amd64.tar.gz
sudo mv go /usr/local
```

Setup golang environment variables

```
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
```

### Installing go-lachesis

```
mkdir -p $HOME/go/src/github.com/Fantom-foundation
cd $HOME/go/src/github.com/Fantom-foundation/
git clone https://github.com/Fantom-foundation/go-lachesis.git
cd go-lachesis/
git checkout tags/v0.7.0-rc.1 -b lachesis-v07rc1
make build
```

Confirm your go-lachesis version

```
./build/lachesis version
Go-Lachesis
Version: 0.7.0-rc.1
...
```

### Installing the Special Fee Contract

The Special Fee Contract (SFC) handles the creation of validators and manages the staking logic internally.

The current sfc release is `2.0.4-rc2`. The ABI output available at `./releases/sfc-abi-2.0.4-rc.2.json`.

### Setup mainnet genesis

Download the default genesis mainnet.toml

```
cd $HOME/go/src/github.com/Fantom-foundation/go-lachesis/build
wget https://raw.githubusercontent.com/Fantom-foundation/lachesis_launch/master/releases/v0.7.0-rc.1/mainnet.toml
```

Modify as required, but do not edit;

[Lachesis.Net.Genesis]
[Lachesis.Net.Genesis.Alloc.x]

### Creating a new account

First we need to setup a new account to receive funds in;

```
./lachesis account new
```

Follow the prompts and supply the password, you will receive output;

```
Your new key was generated

Public address of the key:   0x
Path of the secret key file: 

- You can share your public address with anyone. Others need it to interact with you.
- You must NEVER share the secret key with anyone! The key controls access to your funds!
- You must BACKUP your key file! Without the key, it's impossible to access account funds!
- You must REMEMBER your password! Without the password, it's impossible to decrypt the key!

```
### Adding funds to an account

- [Prenet] Contact the Opera validator group to receive funds
- [Mainnet] Use the bridge to transfer from bep2, erc20, xar to opera

### Transfering funds via the console

```
./lachesis attach
```

```
var tx = {from: "0xSENDER", to: "0xRECEIVER", value: web3.toWei("1000", "ftm")}
personal.sendTransaction(tx, "password")
```


### Create a validator on the SFC

Attach to your running node

```
./lachesis attach
```

```
// Init SFC contract context
abi = JSON.parse('...')
// Note: define variable sfcc (instead of sfc) to avoid clashing with the sfc namespace introduced in go-lachesis v0.7.0-rc1.
sfcc = web3.ftm.contract(abi).at("0xfc00face00000000000000000000000000000000")

// Sanity check
sfcc.stakersNum() // if everything is alright, will return non-zero value
sfcc.stakers(1) // will return staker 1's record

// Create staker
YOUR_ADDRESS = "0xfE19B9Ae8b056eE11d20A8F530326a2C3b99ADca"
sfcc.getStakerID(YOUR_ADDRESS)
personal.unlockAccount(YOUR_ADDRESS, "password", 60) // make sure account is unlocked
tx = sfc.createStake([], {from:YOUR_ADDRESS, value: "3175000000000000000000000"}) // 3175000.0 FTM
// alternatively, use: 
// tx = sfcc.createStake([], {from:YOUR_ADDRESS, value: web3.toWei("3175000.0", "ftm")}) // 3175000.0 FTM

// Sanity checks
ftm.getTransactionReceipt(tx) // check tx was confirmed

sfcc.getStakerID(YOUR_ADDRESS)
```

### Start up a read only server

```
./lachesis --config mainnet.toml --nousb --rpc --rpcaddr=0.0.0.0 --rpcport=3001 --rpcvhosts=* --rpccorsdomain=* --rpcapi=eth,debug,admin,web3,personal,net,txpool,ftm,sfc --ws --wsaddr=0.0.0.0 --wsport=3500 --wsorigins=* --wsapi=eth,debug,admin,web3,personal,net,txpool,ftm,sfc --verbosity 3
```

Attach to the node

```
./lachesis attach
```

Make sure your node has synced up. Use `ftm.blockNumber` to query the current block height.

### Startup as a validator

Stop your current lachesis process

Create an unlock file for the account password

Start the node

```
./lachesis --config mainnet.toml --nousb --validator 0x --unlock 0x --password /path/to/password
```


