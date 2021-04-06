#!/bin/bash

# This script is to set up pm2 for user with readonly node
# Use of pm2 for validator node is not recommended.
sudo apt-get install -y nodejs npm
sudo npm i -g pm2

echo 'module.exports = { apps : [ { name: "fantom", script: "$HOME/runNode.sh", exec_mode: "fork", exec_interpreter: "bash"} ] }' > ~/ecosystem.config.js

echo '#!/bin/bash
$HOME/go/src/github.com/Fantom-foundation/go-lachesis/build/lachesis --nousb' > ~/runNode.sh

pm2 start ~/ecosystem.config.js
