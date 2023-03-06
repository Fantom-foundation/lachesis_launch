# Set up API node

## 1. Launch a read-only Opera node
 - Follow instructions in [launching go-opera readonly node](setup-readonly-node.sh)

### Migrate an existing API node
Running with '--db.preset legacy-ldb --db.migration.mode reformat' doesn't need a resync.

### Start a new API node
You can use either `--db.preset legacy-ldb` or `--db.preset ldb-1` or `--db.preset pbl-1`.

### Enable tracing API
To enable tracing, you can add `--tracenode` flag.

## 2. Enabled API endpoints

By default, the only way to send API requests to the node is via `.ipc` file inside the datadir.

To enable HTTP and/or WS endpoints, add flags:

```shell script
--http --ws
```

The default ports for HTTP and WS are 18545 and 18546. Override them with `--http.port` and `--ws.port` flags if needed.

By default, the endpoints are accessible only by localhost. To allow external requests, add flags:

```shell script
--http --http.vhosts="*" --http.corsdomain="*" --ws --ws.origins="*"
```

The default namespaces are limited to `ftm,eth,abft,dag,rpc,web3`. To allow all the namespaces, add flags:

```shell script
--http --http.api="ftm,eth,debug,admin,web3,personal,net,txpool,sfc" --ws --ws.api="ftm,eth,debug,admin,web3,personal,net,txpool,sfc"
```

Pay attention that the full list of namespaces provides direct access to the node.  
Allow as fewer namespaces as possible and limit access to as fewer hosts as possible.
