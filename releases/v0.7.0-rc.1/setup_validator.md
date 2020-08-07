[Installing build tools](#installing-build-tools)  
[Install golang](#install-golang)  
[Installing go-lachesis](#installing-go-lachesis)  
[Installing the Special Fee Contract](#installing-the-special-fee-contract)  
[Setup mainnet genesis](#setup-mainnet-genesis) 
[Creating a validator on the SFC](#create-a-validator-on-the-sfc)  
[Start up a read only server](#start-up-a-read-only-server)  
[Startup as a validator](#startup-as-a-validator)

This document shows the steps to set up a validator using the version v0.6.0-rc2.

Validator Guides:[https://github.com/Fantom-foundation/go-lachesis/wiki/Validator-Guides](https://github.com/Fantom-foundation/go-lachesis/wiki/Validator-Guides)

### Installing build tools

To install go-lachesis you will need golang version 13 or higher and make

Update your environment

```shell script
sudo apt-get update
sudo apt-get -y upgrade
```

Install build-essential to install make

```shell script
sudo apt-get install -y build-essential
```

### Install golang

```shell script
wget https://dl.google.com/go/go1.13.3.linux-amd64.tar.gz
sudo tar -xvf go1.13.3.linux-amd64.tar.gz
sudo mv go /usr/local
```

Setup golang environment variables

```shell script
export GOROOT=/usr/local/go
export GOPATH=$HOME/go
export PATH=$GOPATH/bin:$GOROOT/bin:$PATH
```

### Installing go-lachesis

```shell script
mkdir -p $HOME/go/src/github.com/Fantom-foundation
cd $HOME/go/src/github.com/Fantom-foundation/
git clone https://github.com/Fantom-foundation/go-lachesis.git
cd go-lachesis/
git checkout tags/v0.7.0-rc.1 -b lachesis-v7rc1
make build
```

Confirm your go-lachesis version

```shell script
./build/lachesis version
Go-Lachesis
Version: 0.7.0-rc.1
...
```

### Installing the Special Fee Contract

The Special Fee Contract (SFC) handles the creation of validators and manages the staking logic internally.

```shell script
sudo snap install solc
export export PATH=/snap/bin:$PATH
```

```shell script
cd $HOME/go/src/github.com/Fantom-foundation/
git clone https://github.com/Fantom-foundation/fantom-sfc.git
cd fantom-sfc/
mkdir build
cd build
solc -o $PWD --optimize --optimize-runs=2000 --ast --asm --abi --bin-runtime --overwrite $PWD/../contracts/sfc/Staker.sol
```

This will generate the contract artifacts in $HOME/go/src/github.com/Fantom-foundation/fantom-sfc/build

The ABI output as follows;

```
# cat Stakers.abi
[{"constant":true,"inputs":[],"name":"minDelegation","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":true,"inputs":[],"name":"stakersNum","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"slashedStakeTotalAmount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"minStakeDecrease","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"short","type":"uint256"},{"internalType":"uint256","name":"long","type":"uint256"}],"name":"_updateGasPowerAllocationRate","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"delegationLockPeriodEpochs","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":true,"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"epochSnapshots","outputs":[{"internalType":"uint256","name":"endTime","type":"uint256"},{"internalType":"uint256","name":"duration","type":"uint256"},{"internalType":"uint256","name":"epochFee","type":"uint256"},{"internalType":"uint256","name":"totalBaseRewardWeight","type":"uint256"},{"internalType":"uint256","name":"totalTxRewardWeight","type":"uint256"},{"internalType":"uint256","name":"baseRewardPerSecond","type":"uint256"},{"internalType":"uint256","name":"stakeTotalAmount","type":"uint256"},{"internalType":"uint256","name":"delegationsTotalAmount","type":"uint256"},{"internalType":"uint256","name":"totalSupply","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"","type":"address"},{"internalType":"uint256","name":"","type":"uint256"}],"name":"delegations","outputs":[{"internalType":"uint256","name":"createdEpoch","type":"uint256"},{"internalType":"uint256","name":"createdTime","type":"uint256"},{"internalType":"uint256","name":"deactivatedEpoch","type":"uint256"},{"internalType":"uint256","name":"deactivatedTime","type":"uint256"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"uint256","name":"paidUntilEpoch","type":"uint256"},{"internalType":"uint256","name":"toStakerID","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"maxDelegatedRatio","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"wrID","type":"uint256"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"prepareToWithdrawStakePartial","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"contractCommission","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"stakerID","type":"uint256"}],"name":"_upgradeStakerStorage","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"maxEpochs","type":"uint256"}],"name":"claimValidatorRewards","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"blocksNum","type":"uint256"},{"internalType":"uint256","name":"period","type":"uint256"}],"name":"_updateOfflinePenaltyThreshold","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"delegationsTotalAmount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"internalType":"bytes","name":"metadata","type":"bytes"}],"name":"updateStakerMetadata","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"minStake","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":true,"inputs":[],"name":"stakeTotalAmount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"stakeLockPeriodTime","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":true,"inputs":[],"name":"delegationsNum","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"","type":"address"},{"internalType":"uint256","name":"","type":"uint256"}],"name":"withdrawalRequests","outputs":[{"internalType":"uint256","name":"stakerID","type":"uint256"},{"internalType":"uint256","name":"epoch","type":"uint256"},{"internalType":"uint256","name":"time","type":"uint256"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"bool","name":"delegation","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"stakeLockPeriodEpochs","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":true,"inputs":[],"name":"version","outputs":[{"internalType":"bytes3","name":"","type":"bytes3"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"legacyDelegations","outputs":[{"internalType":"uint256","name":"createdEpoch","type":"uint256"},{"internalType":"uint256","name":"createdTime","type":"uint256"},{"internalType":"uint256","name":"deactivatedEpoch","type":"uint256"},{"internalType":"uint256","name":"deactivatedTime","type":"uint256"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"uint256","name":"paidUntilEpoch","type":"uint256"},{"internalType":"uint256","name":"toStakerID","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"unlockedRewardRatio","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":true,"inputs":[],"name":"minDelegationIncrease","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"addr","type":"address"}],"name":"getStakerID","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"","type":"address"},{"internalType":"uint256","name":"","type":"uint256"}],"name":"delegationEarlyWithdrawalPenalty","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"firstLockedUpEpoch","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"","type":"address"},{"internalType":"uint256","name":"","type":"uint256"}],"name":"rewardsStash","outputs":[{"internalType":"uint256","name":"amount","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[],"name":"renounceOwnership","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"address","name":"delegator","type":"address"},{"internalType":"uint256","name":"toStakerID","type":"uint256"}],"name":"_syncDelegation","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"currentEpoch","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"value","type":"uint256"}],"name":"_updateBaseRewardPerSec","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"currentSealedEpoch","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"stakersLastID","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"internalType":"address","name":"delegator","type":"address"}],"name":"_upgradeDelegationStorage","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"unstashRewards","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"isOwner","outputs":[{"internalType":"bool","name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"internalType":"address","name":"dagAddress","type":"address"},{"internalType":"address","name":"sfcAddress","type":"address"},{"internalType":"bytes","name":"metadata","type":"bytes"}],"name":"createStakeWithAddresses","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":true,"inputs":[{"internalType":"uint256","name":"stakerID","type":"uint256"},{"internalType":"uint256","name":"_fromEpoch","type":"uint256"},{"internalType":"uint256","name":"maxEpochs","type":"uint256"}],"name":"calcValidatorRewards","outputs":[{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"stakerMetadata","outputs":[{"internalType":"bytes","name":"","type":"bytes"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"totalBurntLockupRewards","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"lockDuration","type":"uint256"},{"internalType":"uint256","name":"toStakerID","type":"uint256"}],"name":"lockUpDelegation","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"slashedDelegationsTotalAmount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"validatorCommission","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":true,"inputs":[],"name":"maxStakerMetadataSize","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":true,"inputs":[{"internalType":"bool","name":"isDelegation","type":"bool"},{"internalType":"uint256","name":"stakerID","type":"uint256"}],"name":"_rewardsBurnableOnDeactivation","outputs":[{"internalType":"bool","name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"toStakerID","type":"uint256"}],"name":"prepareToWithdrawDelegation","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"sfcAddress","type":"address"}],"name":"_sfcAddressToStakerID","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"uint256","name":"e","type":"uint256"},{"internalType":"uint256","name":"v","type":"uint256"}],"name":"epochValidator","outputs":[{"internalType":"uint256","name":"stakeAmount","type":"uint256"},{"internalType":"uint256","name":"delegatedMe","type":"uint256"},{"internalType":"uint256","name":"baseRewardWeight","type":"uint256"},{"internalType":"uint256","name":"txRewardWeight","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"wrID","type":"uint256"},{"internalType":"uint256","name":"toStakerID","type":"uint256"},{"internalType":"uint256","name":"amount","type":"uint256"}],"name":"prepareToWithdrawDelegationPartial","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"withdrawStake","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"to","type":"uint256"}],"name":"createDelegation","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":false,"inputs":[{"internalType":"address","name":"newSfcAddress","type":"address"}],"name":"updateStakerSfcAddress","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"prepareToWithdrawStake","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"minStakeIncrease","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"epochNum","type":"uint256"}],"name":"startLockedUp","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"minDelegationDecrease","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":false,"inputs":[{"internalType":"bytes","name":"metadata","type":"bytes"}],"name":"createStake","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"delegator","type":"address"},{"internalType":"uint256","name":"toStakerID","type":"uint256"},{"internalType":"uint256","name":"_fromEpoch","type":"uint256"},{"internalType":"uint256","name":"maxEpochs","type":"uint256"}],"name":"calcDelegationRewards","outputs":[{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[],"name":"increaseStake","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"to","type":"uint256"}],"name":"increaseDelegation","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"","type":"address"},{"internalType":"uint256","name":"","type":"uint256"}],"name":"lockedDelegations","outputs":[{"internalType":"uint256","name":"fromEpoch","type":"uint256"},{"internalType":"uint256","name":"endTime","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"toStakerID","type":"uint256"}],"name":"withdrawDelegation","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"lockedStakes","outputs":[{"internalType":"uint256","name":"fromEpoch","type":"uint256"},{"internalType":"uint256","name":"endTime","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"stakerID","type":"uint256"}],"name":"_syncStaker","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"delegationLockPeriodTime","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":false,"inputs":[{"internalType":"address","name":"newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"lockDuration","type":"uint256"}],"name":"lockUpStake","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"wrID","type":"uint256"}],"name":"partialWithdrawByRequest","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"maxEpochs","type":"uint256"},{"internalType":"uint256","name":"toStakerID","type":"uint256"}],"name":"claimDelegationRewards","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"stakers","outputs":[{"internalType":"uint256","name":"status","type":"uint256"},{"internalType":"uint256","name":"createdEpoch","type":"uint256"},{"internalType":"uint256","name":"createdTime","type":"uint256"},{"internalType":"uint256","name":"deactivatedEpoch","type":"uint256"},{"internalType":"uint256","name":"deactivatedTime","type":"uint256"},{"internalType":"uint256","name":"stakeAmount","type":"uint256"},{"internalType":"uint256","name":"paidUntilEpoch","type":"uint256"},{"internalType":"uint256","name":"delegatedMe","type":"uint256"},{"internalType":"address","name":"dagAddress","type":"address"},{"internalType":"address","name":"sfcAddress","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"},{"indexed":true,"internalType":"address","name":"dagSfcAddress","type":"address"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"}],"name":"CreatedStake","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"},{"indexed":true,"internalType":"address","name":"oldSfcAddress","type":"address"},{"indexed":true,"internalType":"address","name":"newSfcAddress","type":"address"}],"name":"UpdatedStakerSfcAddress","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"}],"name":"UpdatedStakerMetadata","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"newAmount","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"diff","type":"uint256"}],"name":"IncreasedStake","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"delegator","type":"address"},{"indexed":true,"internalType":"uint256","name":"toStakerID","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"}],"name":"CreatedDelegation","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"delegator","type":"address"},{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"newAmount","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"diff","type":"uint256"}],"name":"IncreasedDelegation","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"from","type":"address"},{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"reward","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"fromEpoch","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"untilEpoch","type":"uint256"}],"name":"ClaimedDelegationReward","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"reward","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"fromEpoch","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"untilEpoch","type":"uint256"}],"name":"ClaimedValidatorReward","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"auth","type":"address"},{"indexed":true,"internalType":"address","name":"receiver","type":"address"},{"indexed":false,"internalType":"uint256","name":"rewards","type":"uint256"}],"name":"UnstashedRewards","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"addr","type":"address"},{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"},{"indexed":false,"internalType":"bool","name":"isDelegation","type":"bool"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"}],"name":"BurntRewardStash","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"}],"name":"PreparedToWithdrawStake","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"}],"name":"DeactivatedStake","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"auth","type":"address"},{"indexed":true,"internalType":"address","name":"receiver","type":"address"},{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"wrID","type":"uint256"},{"indexed":false,"internalType":"bool","name":"delegation","type":"bool"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"}],"name":"CreatedWithdrawRequest","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"penalty","type":"uint256"}],"name":"WithdrawnStake","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"delegator","type":"address"},{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"}],"name":"PreparedToWithdrawDelegation","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"delegator","type":"address"},{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"}],"name":"DeactivatedDelegation","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"delegator","type":"address"},{"indexed":true,"internalType":"uint256","name":"toStakerID","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"penalty","type":"uint256"}],"name":"WithdrawnDelegation","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"auth","type":"address"},{"indexed":true,"internalType":"address","name":"receiver","type":"address"},{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"wrID","type":"uint256"},{"indexed":false,"internalType":"bool","name":"delegation","type":"bool"},{"indexed":false,"internalType":"uint256","name":"penalty","type":"uint256"}],"name":"PartialWithdrawnByRequest","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"fromEpoch","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"endTime","type":"uint256"}],"name":"LockingStake","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"delegator","type":"address"},{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"fromEpoch","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"endTime","type":"uint256"}],"name":"LockingDelegation","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"delegator","type":"address"},{"indexed":true,"internalType":"uint256","name":"oldStakerID","type":"uint256"},{"indexed":true,"internalType":"uint256","name":"newStakerID","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"}],"name":"UpdatedDelegation","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"delegatedMe","type":"uint256"}],"name":"UpdatedStake","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"value","type":"uint256"}],"name":"UpdatedBaseRewardPerSec","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"short","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"long","type":"uint256"}],"name":"UpdatedGasPowerAllocationRate","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"blocksNum","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"period","type":"uint256"}],"name":"UpdatedOfflinePenaltyThreshold","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"previousOwner","type":"address"},{"indexed":true,"internalType":"address","name":"newOwner","type":"address"}],"name":"OwnershipTransferred","type":"event"}]
```

The ABI output of the release `1.1.0-rc1` is available at `./releases/sfc-abi-1.1.json`.

### Setup mainnet genesis

Download the default genesis mainnet.toml

```shell script
cd $HOME/go/src/github.com/Fantom-foundation/go-lachesis/build
wget https://raw.githubusercontent.com/Fantom-foundation/lachesis_launch/master/releases/v0.6.0/mainnet.toml .
```

Modify as required, but do not edit;

[Lachesis.Net.Genesis]
[Lachesis.Net.Genesis.Alloc.x]

### Creating a new account

First we need to setup a new account to receive funds in;

```shell script
./lachesis account new
```

Follow the prompts and supply the password, you will receive output;

```shell script
Your new key was generated

Public address of the key:   0x
Path of the secret key file: 

- You can share your public address with anyone. Others need it to interact with you.
- You must NEVER share the secret key with anyone! The key controls access to your funds!
- You must BACKUP your key file! Without the key, it's impossible to access account funds!
- You must REMEMBER your password! Without the password, it's impossible to decrypt the key!

```
### Adding funds to an account

- [Prenet] Contact the Opera validator group to receive funds
- [Mainnet] Use the bridge to transfer from bep2, erc20, xar to opera

### Transfering funds via the console

```shell script
./lachesis attach
```

```js
var tx = {from: "0x", to: "0x", value: web3.toWei(4000000, "ftm")}
personal.sendTransaction(tx, "password")
```


### Create a validator on the SFC

Attach to your running node

```shell script
./lachesis attach
```

```js
// Init SFC contract context
abi = PASTE_ABI_HERE
sfc.contract = web3.ftm.contract(abi).at("0xfc00face00000000000000000000000000000000")

// Sanity check
sfc.contract.stakersNum() // if everything is allright, will return non-zero value

// Create staker
YOUR_ADDRESS = "0xfE19B9Ae8b056eE11d20A8F530326a2C3b99ADca"
sfc.contract.getStakerID(YOUR_ADDRESS)
personal.unlockAccount(YOUR_ADDRESS, "password", 60) // make sure account is unlocked
tx = sfc.contract.createStake("0x", {from:YOUR_ADDRESS, value: web3.toWei("3175000.0", "ftm")}) // 3175000.0 FTM

// Sanity checks
ftm.getTransactionReceipt(tx) // check tx was confirmed

sfc.contract.getStakerID(YOUR_ADDRESS)
```

### Start up a read only server

```shell script
./lachesis --config mainnet.toml --nousb --rpc --rpcaddr=0.0.0.0 --rpcport=3001 --rpcvhosts=* --rpccorsdomain=* --rpcapi=eth,debug,admin,web3,personal,net,txpool,ftm,sfc --ws --wsaddr=0.0.0.0 --wsport=3500 --wsorigins=* --wsapi=eth,debug,admin,web3,personal,net,txpool,ftm,sfc --verbosity 4
```

Attach to the node

```shell script
./lachesis attach
```

Make sure your node has synced up. Use `ftm.blockNumber` to query the current block height.

### Startup as a validator

Stop your current lachesis process

Create an unlock file for the account password

Start the node

```shell script
./lachesis --config mainnet.toml --nousb --validator 0x --unlock 0x --password /path/to/password
```


