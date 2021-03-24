[Install golang](#install-golang)  
[Installing build tools](#installing-build-tools)  
[Installing go-lachesis](#installing-go-lachesis)  
[Joining the public net](#joining-the-public-mainnet)  
[Creating a new account](#creating-a-new-account)  
[Adding funds to an account](#adding-funds-to-an-account)  
[Create a validator on the SFC](#create-a-validator-on-the-sfc)  
[Startup as a validator](#startup-as-a-validator)  
[Run validator as pm2 process](#run-validator-as-pm2-process)  
[Troubleshooting](#troubleshooting)  
[Error: insufficient funds for gas * price + value](#error-insufficient-funds-for-gas--price--value)  
[Upgrading lachesis](#upgrading-lachesis)  


### Overview

This guide is for connecting to the Opera mainnet only.

Explorer Api Server:[https://api.fantom.network](https://api.fantom.network)

Explorer SocketIo Server: [https://ws.fantom.network/](https://ws.fantom.network/)

Explorer RPC Server:[https://rpc.fantom.network](https://rpc.fantom.network)

Api Documentation is available [here](https://app.swaggerhub.com/apis/devintegral7/fantom-explorer_api/0.1#/info).

- Please replace http://3.136.216.35:3100 with https://api.fantom.network as the api endpoint.

### Installing build tools

To install go-lachesis you will need golang version 14 or higher and make

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

### Installing go-lachesis

```
mkdir -p $HOME/go/src/github.com/Fantom-foundation
cd $HOME/go/src/github.com/Fantom-foundation/
git clone https://github.com/Fantom-foundation/go-lachesis.git
cd go-lachesis/
git checkout release/1.0.0-rc.0
make build
```

Confirm your go-lachesis version

```
./build/lachesis version
Go-Lachesis
Version: 1.0.0-rc.0
```

### Joining the public mainnet

Start your node

```
lachesis --nousb
```

### Creating a new account

First we need to set up a new account to receive funds in;

```
lachesis account new
```

Follow the prompts and supply the password, you will receive output;

```
Your new key was generated

Public address of the key:   0xAddress
Path of the secret key file:

- You can share your public address with anyone. Others need it to interact with you.
- You must NEVER share the secret key with anyone! The key controls access to your funds!
- You must BACKUP your key file! Without the key, it's impossible to access account funds!
- You must REMEMBER your password! Without the password, it's impossible to decrypt the key!

```

### Adding funds to an account

- [Prenet] Contact the Opera validator group to receive funds
- [Mainnet] Use the bridge to transfer from bep2, erc20, xar to opera
