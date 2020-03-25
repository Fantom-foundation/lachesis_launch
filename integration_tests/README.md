# Integration tests

is a set of scripts to run on private lachesis network.
Includes SFC contract tests and node tests.

## Prerequisite

1. Nodes of private network should be installed as systemd daemon and key-files should be in local dirs. See more details about [installing](../ubuntu/02.install.sh).

2. Configure `00.params.sh` with:

    * `NODES` - count of nodes/servers;
    * `NAME` - server name prefix. Servers should be available by `ssh $NAME$i` (where `i` is in range `0..$NODES-1`);
    * `SRC` - local path to clonned [Fantom-foundation/go-lachesis](https://github.com/Fantom-foundation/go-lachesis) repo;
    * `SFC` - local path to clonned [Fantom-foundation/fantom-sfc](https://github.com/Fantom-foundation/fantom-sfc) repo;
3. Complete these steps from directory [lachesis_launch/ubuntu](../ubuntu), these steps are necessary for sfc contract parameters in [32.test-sfc.sh](./32.test-sfc.sh) - `keyObject` and `password`:
    * Edit [00.params.sh](../ubuntu/00.params.sh) for actual values.
    * Run [01.keygen.sh](../ubuntu/01.keygen.sh) to generate keys for validators and SFC-admin.
4. Bash, installed golang and dependencies of Fantom-foundation/fantom-sfc/integration_tests (`npm install`).


## Usage

`./_run.sh` to run the all steps with logging into `test.log` (*Note*: it will drop all the node's databases),

or manualy run any of numbered script to repeat corresponding step.
