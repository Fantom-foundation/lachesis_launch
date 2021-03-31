# Snapshots service

allows to download the network events as single file to sync your node faster, without p2p connections.


## Example of implementation:

 - `./update-snapshot.sh` calls node API to exports new events into snapshot file, manages snapshots and download links. Should be run periodically;
 - `./start-snapshots-server.sh` starts nginx to provide files on http://0.0.0.0:8080. Should be run once;
 - `./stop-snapshots-server.sh` stops nginx server;

Note: scripts and node have to have ./files directory on the same file system.
