This document describes the steps to upgrade a node running go-lachesis v1.0.0-rc0 to the go-opera v1.0.0-rc1.

### Stop the node

Make sure to stop the go-lachesis node first and that the node is not restarted before processing the next steps.

```shell script
killall lachesis
```

### Copy data to the new datadir

```shell script
cp -rf  ~/.lachesis/opera ~/.opera
```

### Checkout and build go-opera

```shell script
git clone https://github.com/Fantom-foundation/go-opera.git
cd go-opera/
git checkout release/$VERSION
make build
```

Confirm your go-opera version

```
./build/opera version
Go-Lachesis
Version: 1.0.0-rc.1
```

### Start the read-only node

```shell script
./build/opera --genesis ~/.opera/genesis.g --nousb
```

Ensure node has synced up.

Validator Guides: [https://github.com/Fantom-foundation/go-opera/wiki/Validator-Guides](https://github.com/Fantom-foundation/go-opera/wiki/Validator-Guides)

### Startup as a validator

The node should be synced before launching the validator.

Stop your current go-opera process.

```shell script
killall opera
```

- wait until the read-only node has stopped.

- then run your validator node:

```shell script
nohup ./build/opera --nousb --validator.pubkey ID --validator.pubkey 0xPubkey --validator.password /path/to/password &
```
