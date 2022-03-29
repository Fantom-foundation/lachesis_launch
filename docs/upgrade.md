This document describes the steps to upgrade a node running go-opera v1.0.2-rc.5 to the go-opera v1.1.0-rc.4

### Stop the node

- Make sure to stop the go-opera node first and that the node is not restarted before processing the next steps

```shell script
killall opera
```

### Update and build go-opera

```shell script
cd go-opera/
git checkout release/1.1.0-rc.4
make
```

- Confirm your go-opera version

```
./build/opera version
Go-Opera
Version: 1.1.0-rc.4
```

### Start the read-only node

```shell script
./build/opera --genesis ~/.opera/genesis.g
```

### Startup as a validator

- Make sure the node has synced up before starting as a validator

> Note: check out validator Guides: [https://github.com/Fantom-foundation/go-opera/wiki/Validator-Guides](https://github.com/Fantom-foundation/go-opera/wiki/Validator-Guides)

- Stop your current go-opera process

```shell script
killall opera
```

- Wait until the node has stopped

- Then run the validator node:

```shell script
nohup ./build/opera --genesis ~/.opera/genesis.g --validator.id ID --validator.pubkey 0xPubkey --validator.password /path/to/password &
```
