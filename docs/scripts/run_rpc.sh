# Default port is 5050
# You can specify a different port, such as --port 5054
# If you run using snapshot download or rerun a node, then don't need to specify --genesis flag 
# You don't need to specify --genesis nor --db.preset again for subsequent runs
nohup ~/go-opera/build/opera --datadir ~/.opera --nousb --maxpeers 110 --cache 12000 --db.preset ldb-1 &