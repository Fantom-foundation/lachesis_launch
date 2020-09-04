# run-lachesis-validator

## 1. Setup an AWS node
- Ubuntu Server 18.04 LTS (or 20.04 LTS) (64-bit)
- Minimum specs: m5.large instance with 2 CPU and 8GB RAM, 250GB of disk space.
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
nohup ./lachesis --config mainnet.toml --nousb --validator 0x --unlock 0x --password /path/to/password &
```

It's complete. Your node is running !!

## run-validator-in-pm2
- Running in pm2 is optional. One can find the scripts to setup and launch Lachesis in PM2 here: 
https://github.com/mhetzel/fantom-lachesis-validator-setup/