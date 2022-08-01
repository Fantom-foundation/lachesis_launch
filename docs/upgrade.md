This document describes the steps to upgrade a node running go-opera v1.1.0 to the go-opera v1.1.1-rc.2

### Stop the node

- Make sure to stop the go-opera node first and that the node is not restarted before processing the next steps

```shell script
killall opera
```

### Update and build go-opera

```shell script
cd go-opera/
git checkout release/1.1.1-rc.2
make
```

- Confirm your go-opera version

```
./build/opera version
Go-Opera
Version: 1.1.1-rc.2
```

### Start the read-only node

Follow [Launching go-opera readonly node](docs/setup-readonly-node.sh)

### Startup as a validator

Follow [Launching go-opera validator node](docs/launch-validator.md)
