# Run Opera validator

## 1. Setup an AWS node
- Ubuntu Server 20.04 LTS 64-bit
- We would recommend the following (or better): 
```
m5.xlarge (4 CPUs and 16GB), 500GB SSD
```
 
- Open up port 22 for SSH, and port 5050 for both TCP and UDP traffic

## 2. Launch a read-only Opera node
 - Follow instructions in [launching go-opera readonly node](setup-readonly-node.sh). We don't recommend using snapsync for a validator datadir.

Wait for your node to sync up

## 3. Run Opera validator
- Stop read-only node

```shell script
killall opera
```

- Wait until the read-only node has stopped

- Then run your validator node:

```shell script
nohup opera --genesis $GENESIS --syncmode full --validator.id ID --validator.pubkey 0xPubkey --validator.password /path/to/password --cache 8000 &
```
, where:
- `ID` is your validator ID (e.g. 25)
- `0xPubkey` is your validator public key. You've generated your key with `opera validator new`.
- `/path/to/password` is a path to a file which contains the password to decrypt the validator key (optional).
- `8000` is amount of memory allocated for go-opera
If you omitted the `--validator.password` flag, then you will be prompted for the password in terminal.

It's complete. Your node is running!
