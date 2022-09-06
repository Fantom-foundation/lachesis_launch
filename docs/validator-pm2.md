## Run validator in pm2

Using pm2 is optional. If your node has crashed, pm2 may turn your node on right away, and it's not recommended.
Make sure to run in non-validate node to sync up the latest events and event blocks first. Once synced up, you can relaunch your node in validator mode.

If you want to process with pm2, continue with the following steps

Install nodejs, npm and pm2

```shell script
sudo apt-get install nodejs npm
sudo npm i -g pm2
```

Create a script to run the node

```shell script
touch runNode.sh
chmod +x runNode.sh
```

and put in the following content with Opera flags

```shell script
#!/bin/sh
opera your-flags
```

Create the pm2 config file

```shell script
touch ecosystem.config.js
```

and put in the following content

```shell script
module.exports = { apps : [ { name: "fantom", script: "$HOME/runNode.sh", exec_mode: "fork", exec_interpreter: "bash"} ] }
```

Start the pm2 process

```shell script
pm2 start ./ecosystem.config.js
```

Use following commands

```shell script
// Check node status
pm2 status

// Check node logs
pm2 logs

// Create an autostart script to automatically run the node on server startup
pm2 save
```
