[Short guide](./scripts/setup-validator-short.md)  
[Install golang](./README.md#install-golang)  
[Installing build tools](./README.md#installing-build-tools)  
[Installing go-lachesis](./README.md#installing-go-lachesis)  
[Installing the Special Fee Contract](#installing-the-special-fee-contract)  
[Creating a validator](./README.md#create-a-validator-on-the-sfc)  
[Setup mainnet genesis](#setup-mainnet-genesis)  
[Creating a new account](./README.md#creating-a-new-account)  
[Adding funds to an account](./README.md#adding-funds-to-an-account)  
[Transfering funds via the console](#transfering-funds-via-the-console)   
[Start up a read only server](#start-up-a-read-only-server)   

Joining the mainnet  
Transferring tokens from ERC20 or BEP2 to mainnet  

### Installing the Special Fee Contract

The Special Fee Contract (SFC) handles the creation of validators and manages the staking logic internally.

The current sfc release is `2.0.4-rc2`. The ABI output available at [SFC 2.0.4-rc2 ABI](./releases/sfc-abi-2.0.4-rc.2.json).

### Setup mainnet genesis

The default genesis config is located in `releases` directory by tags, for example `./releases/v0.7.0-rc.1/mainnet.toml`.
Download the latest genesis mainnet.toml:

```shell script
cd $HOME/go/src/github.com/Fantom-foundation/go-lachesis/
wget https://raw.githubusercontent.com/Fantom-foundation/lachesis_launch/master/releases/v0.7.0-rc.1/mainnet.toml
```

Modify as required, but do not edit;

[Lachesis.Net.Genesis]
[Lachesis.Net.Genesis.Alloc.x]


### Transfering funds via the console

```
./lachesis attach
```

```
var tx = {from: "0xSENDER", to: "0xRECEIVER", value: web3.toWei("1000", "ftm")}
personal.sendTransaction(tx, "password")
```

### Start up a read only server   
```shell script
./lachesis --config mainnet.toml --nousb --rpc --rpcaddr=0.0.0.0 --rpcport=3001 --rpcvhosts=* --rpccorsdomain=* --rpcapi=eth,debug,admin,web3,personal,net,txpool,ftm,sfc --ws --wsaddr=0.0.0.0 --wsport=3500 --wsorigins=* --wsapi=eth,debug,admin,web3,personal,net,txpool,ftm,sfc --verbosity 3
```

If you need to disable the node check for the latest version, add `--nocheckversion` to the command line.
