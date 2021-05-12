This document describes the steps to upgrade a node running go-lachesis v1.0.0-rc0 to the go-opera v1.0.0-rc1

### Stop the node

- Make sure to stop the go-lachesis node first and that the node is not restarted before processing the next steps

```shell script
killall lachesis
```

### Copy data to the new datadir

```shell script
cp -rf  ~/.lachesis/opera ~/.opera
```

> Note: if your go-lachesis datadir is `/path/to/lachesis-datadir`, then it will have `opera` subdirectory after go-opera
migration is complete. You can use this subdirectory as your go-opera datadir. Also this subdirectory contains `genesis.g` file
which should be used as a genesis file specified with `--genesis` flag.

### Checkout and build go-opera

```shell script
git clone https://github.com/Fantom-foundation/go-opera.git
cd go-opera/
git checkout release/1.0.0-rc.1
make
```

- Confirm your go-opera version

```
./build/opera version
Go-Opera
Version: 1.0.0-rc.1
```

### Start the read-only node

```shell script
./build/opera --genesis ~/.opera/genesis.g --nousb
```

### Startup as a validator

- Make sure the node has synced up before starting as a validator

> Note: check out validator Guides: [https://github.com/Fantom-foundation/go-opera/wiki/Validator-Guides](https://github.com/Fantom-foundation/go-opera/wiki/Validator-Guides)

- Stop your current go-opera process

```shell script
killall opera
```

- Wait until the node has stopped

- Retrieve the validator pubkey:

```shell script
echo 0x$(ls ~/.opera/keystore/validator | head -1)
```

- Then run the validator node:

```shell script
nohup ./build/opera --genesis ~/.opera/genesis.g --nousb --validator.pubkey ID --validator.pubkey 0xPubkey --validator.password /path/to/password &
```
