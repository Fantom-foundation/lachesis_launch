[Install golang](./README.md#install-golang)  
[Installing build tools](./README.md#installing-build-tools)  
[Installing testnet go-lachesis](#installing-testnet-go-lachesis)  
[Joining the public net](#starting-your-node-and-joining-the-public-testnet)  
[Creating a new account](#creating-a-new-account)  
[Adding funds to an account](#adding-funds-to-an-account)  
[Create a validator on the SFC](#create-a-validator-on-the-sfc)  
[Startup as a validator](#startup-as-a-validator)  
[Run validator as pm2 process](#run-validator-as-pm2-process)  
[Troubleshooting](./README.md#troubleshooting)  
[Error: insufficient funds for gas * price + value](./README.md#error-insufficient-funds-for-gas--price--value)  
[Deploy a contract](#deploy-a-contract)

### Overview

This guide is for connecting to the Opera testnet only.

The testnet consists of 3 nodes:

```
enode://563b30428f48357f31c9d4906ca2f3d3815d663b151302c1ba9d58f3428265b554398c6fabf4b806a49525670cd9e031257c805375b9fdbcc015f60a7943e427@3.213.142.230:7946

enode://8b53fe4410cde82d98d28697d56ccb793f9a67b1f8807c523eadafe96339d6e56bc82c0e702757ac5010972e966761b1abecb4935d9a86a9feed47e3e9ba27a6@3.227.34.226:7946

enode://1703640d1239434dcaf010541cafeeb3c4c707be9098954c50aa705f6e97e2d0273671df13f6e447563e7d3a7c7ffc88de48318d8a3cc2cc59d196516054f17e@52.72.222.228:7946
```

Latest sfc commit hash is [463d8b85a74895917d91ab3c25d7b027604c8b32](https://github.com/Fantom-foundation/fantom-sfc/commit/463d8b85a74895917d91ab3c25d7b027604c8b32)


Explorer Api Server:[3.213.142.230:6000](http://3.213.142.230:6000)

Explorer SocketIo Server: [3.213.142.230:6001](http://3.213.142.230:6001)

Api Documentation is available [here](https://app.swaggerhub.com/apis/devintegral7/fantom-explorer_api/0.1#/info).

- Please replace http://3.136.216.35:3100 with http://3.213.142.230:6000 as the api endpoint.


### Installing testnet go-lachesis

```
git clone https://github.com/Fantom-foundation/go-lachesis.git
cd go-lachesis/
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
   wallet                             Manage Ethereum presale wallets
   help                               Shows a list of commands or help for one command
```

### Starting your node and joining the public testnet

```
cd build

wget https://raw.githubusercontent.com/Fantom-foundation/lachesis_launch/master/testnet.toml

./lachesis --config testnet.toml --nousb --datadir ~/.lachesis/testnet
```

### Creating a new account

First we need to setup a new account to receive funds in;

```
./lachesis --testnet account new <YOUR IPC ENDPOINT> --datadir ~/.lachesis/testnet
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

- Email [contact@fantom.foundation](mailto:contact@fantom.foundation)


### Create a validator on the SFC

Attach to your running node

```
./lachesis --testnet attach <YOUR IPC ENDPOINT> --datadir ~/.lachesis/testnet
```

Now you have to [initialize contract context](./README.md##init-SFC-contract-context), and when a contract context is created, you can proceed to [creating a staker](./README.md##creating-a-staker).

### Startup as a validator

Stop your current lachesis process

Create an unlock file for the account password

Start the node

```
./lachesis --config testnet.toml --nousb --validator 0x --unlock 0x --password /path/to/password <YOUR IPC ENDPOINT>
```

### Run validator as pm2 process   
Install nodejs, npm and pm2

```
sudo apt-get install nodejs npm
sudo npm i -g pm2
```

Create a script to run the node

```
touch runNode.sh
chmod +x runNode.sh
```

and put in the following content

```
#!/bin/sh
$HOME/go/src/github.com/Fantom-foundation/go-lachesis/build/lachesis --config $HOME/go/src/github.com/Fantom-foundation/go-lachesis/build/testnet.toml --nousb --validator 0x --unlock 0x --password /path/to/password
```

Create the pm2 config file

```
touch ecosystem.config.js
```

and put in the following content

```
module.exports = { apps : [ { name: "fantom", script: "$HOME/runNode.sh", exec_mode: "fork", exec_interpreter: "bash"} ] }
```

Start the pm2 process

```
pm2 start ./ecosystem.config.js
```

Use following commands

```
// Check node status
pm2 status

// Check node logs
pm2 logs

// Create an autostart script to automatically run the node on server startup
pm2 save
```   

## Deploy a contract

1. Unlock your account:

`personal.unlockAccount(YOUR_ADDRESS, "password", 60) // make sure account is unlocked`

2. Deploy contract:

```
ftm.Contract(<ABI, {
    from: <YOUR ADDRESS>,
    gasPrice: <gasPrice>
    data: <bytecode>
});
```

Example:

```
aTemplate = ftm.contract([{"inputs":[{"internalType":"string","name":"initMessage","type":"string"}],"stateMutability":"nonpayable","type":"constructor"},{"inputs":[],"name":"message","outputs":[{"internalType":"string","name":"","type":"string"}],"stateMutability":"view","type":"function"},{"inputs":[{"internalType":"string","name":"newMessage","type":"string"}],"name":"update","outputs":[],"stateMutability":"nonpayable","type":"function"}]);
aContract = aTemplate.new({from: "0x8D23688C84423c7B1104ea07824e107c3c6C0DcE",
    gas: '3000000',
    gasPrice: '20000000000',
    data: "0x608060405234801561001057600080fd5b5060405161047d38038061047d8339818101604052602081101561003357600080fd5b810190808051604051939291908464010000000082111561005357600080fd5b90830190602082018581111561006857600080fd5b825164010000000081118282018810171561008257600080fd5b82525081516020918201929091019080838360005b838110156100af578181015183820152602001610097565b50505050905090810190601f1680156100dc5780820380516001836020036101000a031916815260200191505b50604052505081516100f6915060009060208401906100fd565b5050610198565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061013e57805160ff191683800117855561016b565b8280016001018555821561016b579182015b8281111561016b578251825591602001919060010190610150565b5061017792915061017b565b5090565b61019591905b808211156101775760008155600101610181565b90565b6102d6806101a76000396000f3fe608060405234801561001057600080fd5b50600436106100365760003560e01c80633d7403a31461003b578063e21f37ce146100e3575b600080fd5b6100e16004803603602081101561005157600080fd5b81019060208101813564010000000081111561006c57600080fd5b82018360208201111561007e57600080fd5b803590602001918460018302840111640100000000831117156100a057600080fd5b91908080601f016020809104026020016040519081016040528093929190818152602001838380828437600092019190915250929550610160945050505050565b005b6100eb610177565b6040805160208082528351818301528351919283929083019185019080838360005b8381101561012557818101518382015260200161010d565b50505050905090810190601f1680156101525780820380516001836020036101000a031916815260200191505b509250505060405180910390f35b8051610173906000906020840190610205565b5050565b6000805460408051602060026001851615610100026000190190941693909304601f810184900484028201840190925281815292918301828280156101fd5780601f106101d2576101008083540402835291602001916101fd565b820191906000526020600020905b8154815290600101906020018083116101e057829003601f168201915b505050505081565b828054600181600116156101000203166002900490600052602060002090601f016020900481019282601f1061024657805160ff1916838001178555610273565b82800160010185558215610273579182015b82811115610273578251825591602001919060010190610258565b5061027f929150610283565b5090565b61029d91905b8082111561027f5760008155600101610289565b9056fea264697066735822122057646eddce1711bb7c0e9a841227a3600625c0650a934f6cdc955f7658adc9f564736f6c63430006000033"});
```
