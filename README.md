### Overview

The latest version of a blockchain node for the Opera network is `go-opera 1.1.3-rc.4`. The oldest supported version is `go-opera 1.1.1-rc.2`.

[Upgrade instruction](docs/upgrade.md)

[Migration flags](docs/upgrade.md#recommendations)

### List of genesis files
[Current list of genesis files](docs/genesis-files.md)

The upgrade is recommended for all nodes including API nodes and validator nodes.

### Instructions for a read node
Read node can use `go-opera v1.1.3-rc.4` in either snap sync or full sync mode.

1. [Launching go-opera readonly node](docs/setup-readonly-node.sh)

### Instructions for an API node

API node can use `go-opera v1.1.3-rc.4` in either snap sync or full sync mode.
In a case if full history is needed, then use the latest archive genesis file in full sync mode.

1. [Launching go-opera readonly node](docs/setup-readonly-node.sh)
2. [Launching go-opera API node](docs/setup-api-node.md)

### Instructions for a validator

Validator node is recommended to use `go-opera v1.1.3-rc.4` in full sync mode.

1. [Launching go-opera readonly node](docs/setup-readonly-node.sh)
2. [Creation of a validator](docs/create-validator.md)
3. [Launching go-opera validator node](docs/launch-validator.md)

### Instructions for a delegator

1. [Delegator instructions](docs/delegator.md)
2. [SFTM instructions](docs/sftm.md)

### Instructions for launching a private network

1. [Launching go-opera private network](docs/launch-private-network.md)
