# default port is 5050
# you can specify a different port, such as --port 5054
# if you run using snapshot download or rerun a node, then don't need to specify --genesis flag 
nohup ~/go-opera/build/opera --datadir ~/.opera --nousb --maxpeers 110 --cache 9000 --db.preset ldb-1 &