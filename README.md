[Install golang](#install-golang)  
[Installing build tools](#installing-build-tools)  
[Installing go-lachesis](#installing-go-lachesis)  
[Joining the mainnet](#joining-the-mainnet)  



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
make build
```

Confirm your go-lachesis version

```
./build/lachesis help

VERSION:
   0.3.0-dev
COMMANDS:
   account                            Manage accounts
   attach                             Start an interactive JavaScript environment (connect to node)
   console                            Start an interactive JavaScript environment
   dumpconfig                         Show configuration values
   js                                 Execute the specified JavaScript files
   wallet                             Manage Ethereum presale wallets
   help                               Shows a list of commands or help for one command
```

### Joining the mainnet

Download the default genesis config.toml

```
cd $HOME/go/src/github.com/Fantom-foundation/go-lachesis/
wget https://raw.githubusercontent.com/Fantom-foundation/lachesis_launch/master/config.toml .
```

Start your node

```
./lachesis --config config.toml --nousb
```
