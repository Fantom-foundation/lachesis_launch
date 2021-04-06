# run-lachesis-validator

## 1. Setup an AWS node
- Ubuntu Server 20.04 LTS 64-bit
- We would recommend the following (or better) for validator nodes: 
m5.xlarge (4 CPUs and 16GB), 500GB SSD, CPU with 3.1GHz.
- For readonly nodes, minimum specs is: r5.large (2CPUs and 16GB), 500GB SSD.
- Open up ports 22 (SSH), and 5050 (TCP and UDP).

## 2. Launch a read-only Lachesis node
 - Run go-lachesis v0.7.0-rc1 as the default user (or a sudo user):
```
curl -s https://raw.githubusercontent.com/Fantom-foundation/lachesis_launch/master/scripts/readonly-lachesis-0.7.0-rc1.sh | bash
```
 - Run go-lachesis v1.0.0-rc0 as the default user (or a sudo user):
```
curl -s https://raw.githubusercontent.com/Fantom-foundation/lachesis_launch/master/scripts/readonly-lachesis-1.0.0-rc1.sh | bash
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
nohup ./lachesis --config mainnet.toml --nousb --validator 0x --unlock 0x --password /path/to/password &
```

It's complete. Your node is running !!

## run-node-in-pm2
- Running in pm2 is optional.
- stop read-only node first, then run:
```
curl -s https://raw.githubusercontent.com/Fantom-foundation/lachesis_launch/master/scripts/setup-pm2.sh | bash
```