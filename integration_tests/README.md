# Integration tests

is a set of scripts to run on private lachesis network.


## Prerequisite

1. Nodes of private network should be installed as systemd daemon. See more details about [installing](../ubuntu/02.install.sh).

2. Configure `00.params.sh` with:

    * `NODES` - count of nodes/servers;
    * `NAME` - server name prefix. Servers should be available by `ssh $NAME$i` (where `i` is in range `0..$NODES-1`);
    * `SRC` - local path to clonned [Fantom-foundation/go-lachesis](https://github.com/Fantom-foundation/go-lachesis) repo;
    * `SFC` - local path to clonned [Fantom-foundation/fantom-sfc](https://github.com/Fantom-foundation/fantom-sfc) repo;
    * `KEYSTORE_DIR` - path to lachesis `data_dir` with postfix - `.lachesis`. Example `/tmp/testnode0/.lachesis`;
    * `PASSWORD` - set the password to this variable if `*.pswd` file with the password does not exist in `KEYSTORE_DIR`.
3. Bash, installed golang and dependencies of Fantom-foundation/fantom-sfc/integration_tests (`npm install`).


## Usage

`./_run.sh` to run the all steps with logging into `test.log` (*Note*: it will drop all the node's databases),

or manualy run any of numbered script to repeat corresponding step.
