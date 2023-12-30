# Run a trace node


# Default port is 5050. 
# You can specify a different port, such as --port 5054
# You don't need to specify --genesis nor --db.preset again for subsequent runs
# You can use --db.preset pbl-1 or ldb-1
# Remember to include --tracenode flag

# For the first run (fresh new set up), please use the below. A fresh run can take 4+ weeks to sync.
# nohup ./opera --genesis ~/mainnet-5577-full-mpt.g --datadir ~/nonpruned/.opera --maxpeers 110 --cache 12000 --db.preset pbl-1 --tracenode &

# If you run using snapshot download or rerun a node (after it's synced), then you can enable --http. 
nohup ./opera --nat=extip:<IP> --http --http.port=8080 --http.vhosts=* --http.addr=0.0.0.0 --http.vhosts=* --http.corsdomain=* --http.api=eth,web3,net,txpool,ftm,trace --txpool.nolocals --maxpeers 110 --cache 12000 --tracenode &

