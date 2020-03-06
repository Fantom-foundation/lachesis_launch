## Deploy example

some practice to deploy public network validators on ubuntu servers


### Prerequisite

 - ubuntu servers are available by `ssh nameN`, where "N" is a number between 0 and nodecount-1.
   Use `~/.ssh/config` to configure hosts IP and identity file.
 - sudo without password prompting on servers.
 - bash, awk, jq etc.
 - go-lachesis sources.


### Steps

1. Edit [00.params.sh](./00.params.sh) for actual values.
2. Run [01.keygen.sh](./01.keygen.sh) to generate keys for validators and SFC-admin.
3. Update `lachesis/genesis/genesis.go:TestGenesis()` source to get your custom genesis with generated keys.
4. [02.install.sh](./02.install.sh) nodes as systemd service.
5. See [03.status.sh](./03.status.sh) of nodes.


### Work hints

 - attach to console without port: `sudo /home/lachesis/lachesis attach --exec "admin.nodeInfo.enode" /home/lachesis/lachesis.ipc`;
 - use `--allow-insecure-unlock` arg to avoid `Account unlock with HTTP access is forbidden!` error;
 - update systemd after args changing: `sudo vi /home/lachesis/lachesis-node.service && sudo systemctl daemon-reload`;
 - restart node: `sudo systemctl restart lachesis-node`;
 - node status: `sudo systemctl status lachesis-node`;
 - real-time logs: `journalctl -n 100 -f -u lachesis-node`;
