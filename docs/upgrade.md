This document describes the steps to upgrade a node running go-opera v1.1.1 to the go-opera v1.1.2-rc.2

### Stop the node

- Make sure to stop the go-opera node first and that the node is not restarted before processing the next steps

```shell script
killall opera
```

### Update and build go-opera

```shell script
cd go-opera/
git checkout release/1.1.2-rc.2
make
```

- Confirm your go-opera version

```
./build/opera version
Go-Opera
Version: 1.1.2-rc.2
```

### Migration flags

There's two migration options forF upgrading to 1.1.2-rc.2:
- Reformatting legacy DBs layout: `--db.migration.mode reformat --db.preset legacy-ldb`.
  This option is instant but involves no performance improvement for blocks/events processing.
- Rebuilding DBs according to a new layout: `--db.migration.mode rebuild --db.preset X`, where X is a selected DBs layout.
  Migration will take a lot of time - for an NVMe SSD drive, the number of hours would be roughly `datadir size in GB` divided by 100 `GB/hour`.
  If the remaining disk space is insufficient to store a copy of largest DB in datadir/chaindata,
  then the migration will take up to 3 times longer, depending on available disk space.

Flag `--db.migration.mode` is mandatory only for first launch.

There's 4 options for the new `--db.preset` flag:
- `ldb-1` - fastest LevelDB layout (default option).
- `legacy-ldb` - legacy LevelDB layout.
- `pbl-1` - fastest Pebble layout.
- `legacy-pbl` - legacy Pebble layout from 1.1.1-rc.2-pebble.

Pebble offers better performance and smaller IO utilization on average, especially with extended cache. Even though it's faster on average, it may involve periodic delays with spikes of IO activity.
We don't recommend using `pbl-1` or `legacy-pbl` layouts for validators.

### Start the read-only node

Follow [Launching go-opera readonly node](docs/setup-readonly-node.sh) and substitute migration flags above.

### Startup as a validator

Follow [Launching go-opera validator node](docs/launch-validator.md) and substitute migration flags above.
