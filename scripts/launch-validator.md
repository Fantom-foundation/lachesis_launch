# run-opera-validator

## 1. Setup an AWS node
- Ubuntu Server 20.04 LTS 64-bit
- We would recommend the following (or better): 
```
m5.xlarge (4 CPUs and 16GB), 500GB SSD
r5.large (2 CPUs and 16GB), 500GB SSD
```
 
- Open up port 22 for SSH, and port 5050 for both TCP and UDP traffic

## 2. Launch a read-only Opera node
 - Follow instructions in [launching go-opera readonly node](./setup-readonly-node.sh)

Wait for your node to sync up.

## 3. Run Opera validator
- Stop read-only node

```shell script
killall opera
```

- Wait until the read-only node has stopped

- Then run your validator node:

```shell script
nohup opera --nousb --validator.pubkey ID --validator.pubkey 0xPubkey --validator.password /path/to/password &
```

It's complete. Your node is running!
