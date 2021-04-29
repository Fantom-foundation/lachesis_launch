#!/bin/bash

#######################################
# Bash script to import EVM history into go-opera
#######################################

DATADIR=~/.opera
# Pick a file for your network
# The file for mainnet is mainnet-evm-history-5576.gz
# File file for public testnet is testnet-evm-history-2457.gz
HISTORY_FILE='mainnet-evm-history-5576.gz'

# Download the EVM history file
wget https://opera.fantom.network/$HISTORY_FILE

# Import the EVM history
opera --datadir $DATADIR import evm $HISTORY_FILE

# Erase the EVM history file
rm $HISTORY_FILE

# Verify the EVM history to make this procedure trustless
# If you've already tested this exact file before, then it is not necessary to repeat the check
opera --datadir $DATADIR check evm
