### Overview

The latest version of a blockchain node for the Opera network is `go-opera 1.1.1-rc.2`. The oldest supported version is `go-opera 1.1.0-rc.4`.

### List of genesis files
[Current list of genesis files](docs/genesis-files.md)

With `go-opera v1.1.1-rc.2`, new read nodes can use new customizable genesis files and to sync using snapsync mode.
The upgrade is highly recommended for all nodes including API nodes and validator nodes.

Note that, if you're running a 1.1.0-rc.X, after the upgrade to 1.1.1-rc.2, it won't be possible to use the old genesis files (mainnet.g and testnet.g). 
Instead, you can omit --genesis flag and you don't need to download a new genesis file (as the file is no longer mandatory for already initialized nodes).

### Instructions for a read node
Read node can use `go-opera v1.1.1-rc.2` in either snap sync or full sync mode.

1. [Launching go-opera readonly node](docs/setup-readonly-node.sh)

### Instructions for an API node

API node is recommended to use `go-opera v1.1.1-rc.2` in full sync mode.

1. [Launching go-opera readonly node](docs/setup-readonly-node.sh)
2. [Launching go-opera API node](docs/setup-api-node.md)

### Instructions for a validator

Validator node is recommended to use `go-opera v1.1.1-rc.2` in full sync mode.

1. [Launching go-opera readonly node](docs/setup-readonly-node.sh)
2. [Creation of a validator](docs/create_validator.md)
3. [Launching go-opera validator node](docs/launch-validator.md)

### Instructions for a delegator

1. [Delegator instructions](docs/delegator.md)
2. [SFTM instructions](docs/sftm.md)

### Instructions for launching a private network

1. [Launching go-opera private network](docs/launch-private-network.md)
