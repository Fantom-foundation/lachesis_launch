## Performance testing

some practice to run fake network validators on ubuntu servers


### Prerequisite

 - ubuntu servers are available by `ssh nameN`, where "N" is a number between 0 and nodecount-1.
   Use `~/.ssh/config` to configure hosts IP and identity file.
 - sudo without password prompting on servers.
 - bash, awk, jq etc.
 - go-lachesis sources.


### Steps

1.  Edit [00.params.sh](./00.params.sh) for actual values.
2.  Run [10.fakenet-config.sh](./10.fakenet-config.sh) to make configs.
3.  Read and do the output instructions: build [lachesis](https://github.com/devintegral/go-lachesis/tree/perf-testing/cmd/lachesis/) and [tx-storm](https://github.com/devintegral/go-lachesis/tree/perf-testing/cmd/tx-storm/) binaries, check configs.
4.  [20.fakenet-install.sh](./20.fakenet-install.sh) runs nodes as systemd service.
5.  Check [21.status.sh](./21.status.sh) of nodes.
6.  [30.txstorm-install.sh](./30.txstorm-install.sh) INSTALL tx generator for each node.
7.  [31.txstorm-start.sh](./31.txstorm-start.sh) runs tx generator for each node.
8.  See TPS with [32.tps-log.sh](./31.tps-log.sh).
9.  [70.txstorm-stop.sh](./70.txstorm-stop.sh) stops tx genearators.
10. [80.fakenet-reset.sh](./80.fakenet-reset.sh) to start again.
11. [88.total-destroy.sh](./88.total-destroy.sh) for clean.


