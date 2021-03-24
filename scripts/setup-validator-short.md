# run-lachesis-validator

## 1. Setup an AWS node
- Ubuntu Server 20.04 LTS 64-bit
- We would recommend the following (or better): 
m5.xlarge (4 CPUs and 16GB), 500GB SSD.
r5.large (2CPUs and 16GB), 500GB SSD.
 
- Open up port 22 for SSH, and port 5050 for both TCP and UDP traffic.

## 2. Launch a read-only Lachesis node
 - as the default user (or a sudo user), run

```
curl -s https://raw.githubusercontent.com/Fantom-foundation/lachesis_launch/master/scripts/setup-readonly-node.sh | bash
```

Wait for your node to sync up.

## 3. Create a validator wallet and validator

## 4. Run Lachesis validator
- stop read-only node

```
killall lachesis
```

- then run your validator node:

```
nohup ./lachesis --nousb --validator 0xAddress --unlock 0xAddress --password /path/to/password &
```

It's complete. Your node is running !!

## run-validator-in-pm2
- Running in pm2 is optional.