This document describes the steps to upgrade a node running go-opera v1.1.1 to the go-opera v1.1.2-rc.5

## Update go-opera version
### Stop the node

- Make sure to stop the go-opera node first and that the node is not restarted before processing the next steps

```shell script
pkill opera
```

### Update and build go-opera

```shell script
cd go-opera/
git checkout release/1.1.2-rc.5
make
```

- Confirm your go-opera version

```
./build/opera version
Go-Opera
Version: 1.1.2-rc.5
```

#### Migration flags in 1.1.2-rc.5

There's two migration options for upgrading to 1.1.2-rc.5:
- Preserving legacy DBs layout: `--db.migration.mode reformat --db.preset legacy-ldb`.
  This option is instant but involves no performance improvement for blocks/events processing.
- Rebuilding DBs according to a new layout: `--db.migration.mode rebuild --db.preset X`, where X is a selected DBs layout.
  Migration will take a lot of time - for an NVMe SSD drive, the number of hours would be roughly `datadir size in GB` divided by 100 `GB/hour`.
  If the remaining disk space is insufficient to store a copy of largest DB in datadir/chaindata,
  then the migration will take up to 3 times longer, depending on available disk space.

Flags `--db.migration.mode` and `--db.preset` are mandatory only for first launch.

There are 2 options for the new `--db.preset` flag:
- `ldb-1` - fastest LevelDB layout (default option).
- `pbl-1` - fastest Pebble layout.

Pebble offers slightly better performance and smaller IO utilization on average, especially with extended cache.
We don't recommend using `pbl-1` or `legacy-pbl` layouts for validators or any other mission-critical nodes.

## Recommendations
### Migrate an existing node

To migrate from an existing opera version (1.1.1-rc.2), please use: 
- `--db.migration.mode reformat --db.preset legacy-ldb`

This applies to all types of nodes (including API, rpc and validator nodes). Reformatting will finish almost instantly.

### Sync a new node from scratch

#### Validator nodes and critical nodes
You can use: `--db.preset ldb-1`  
You don't need `--db.migration.mode` flag, if you don’t migrate an existing DB.

#### Non-critical nodes (including rpc, api and tracing)
You can use either:
- `--db.preset ldb-1`   (This flag will sync slightly faster, but  may respond slower on multiple parallel API queries)
- `--db.preset pbl-1`  (This flag will sync longer, but have more stable API response time).

#### Start the read-only node

Follow [Launching go-opera readonly node](docs/setup-readonly-node.sh) and substitute migration flags above.

#### Start as a validator

Follow [Launching go-opera validator node](docs/launch-validator.md) and substitute migration flags above.

### Cache size
Regarding cache size, you may check your node available memory size and consider changing the default Opera cache size to a bigger value based on that. 
For example: `--cache 16000`  for a node with more than 16GB of RAM. 
There is an imposed limit of 60% of the available RAM of your machine, if cache size is specified larger than that value.
