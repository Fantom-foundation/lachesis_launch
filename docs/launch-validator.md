# Run Opera validator

## 1. Setup an AWS node
- Ubuntu Server 20.04 LTS 64-bit
- We would recommend the following (or better): 
```
m5.xlarge (4 CPUs and 16GB), 500GB SSD
```
 
- Open up port 22 for SSH, and port 5050 for both TCP and UDP traffic

## 2. Launch a read-only Opera node
- Follow instructions in [launching go-opera readonly node](setup-readonly-node.sh) with limitations:
- - Use only `--syncmode full` option.
- - Use only `--db.preset ldb-1` or `--db.preset legacy-ldb` options.

Wait for your node to sync up. You may add `--exitwhensynced.age 10s` flag to automatically stop the node when synced.

## 3. Run Opera validator
- Stop read-only node

```shell script
killall opera
```

- Wait until the read-only node has stopped

- Then run your validator node:

```shell script
nohup opera --syncmode full --cache $CACHE --validator.id ID --validator.pubkey 0xPubkey &
```
- `ID` is your validator ID (e.g. 25)
- `0xPubkey` is your validator public key. You've generated your key with `opera validator new`.
If you omitted the `--validator.password` flag, then you will be prompted for the password in terminal.
- `$CACHE` is amount of memory allocated for go-opera. Substitute half of server RAM capacity in MB.
- Use only `--syncmode full` option.

Enter the password when prompted.

Ensure that the validator key password is not stored on the server. Instead, enter it manually following each restart.

It's complete. Your node is running!
