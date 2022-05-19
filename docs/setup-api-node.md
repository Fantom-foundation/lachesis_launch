# Set up API node

## 1. Launch a read-only Opera node
 - Follow instructions in [launching go-opera readonly node](setup-readonly-node.sh)

## 2. Enabled API endpoints

By default, the only way to send API requests to the node is via `.ipc` file inside the datadir.

To enable HTTP and/or WS endpoints, use:

```shell script
opera --genesis $NETWORK --http --ws
```

The default ports for HTTP and WS are 18545 and 18546. Override them with `--http.port` and `--ws.port` flags if needed.

By default, the endpoints are accessible only by localhost. To allow external requests, use:

```shell script
opera --genesis $NETWORK --http --http.vhosts="*" --http.corsdomain="*" --ws --ws.origins="*"
```

The default namepsaces are limited to `ftm,eth,abft,dag,rpc,web3`. To allow all the namepsaces, use:

```shell script
opera --genesis $NETWORK --http --http.api="ftm,eth,debug,admin,web3,personal,net,txpool,sfc" --ws --ws.api="ftm,eth,debug,admin,web3,personal,net,txpool,sfc"
```

Pay attention that the full list of namepsaces provides direct access to the node.  
Allow as fewer namespaces as possible and limit access to as fewer hosts as possible.
