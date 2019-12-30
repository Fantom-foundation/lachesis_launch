# Staking and Delegating (Work in Progress)

**Note**: All references to "staker" and "stakers" refer to "validating nodes".


## Loading the sfc

```
abi = JSON.parse('[{"constant":true,"inputs":[],"name":"minDelegation","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":true,"inputs":[],"name":"bondedRatio","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"stakersNum","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"slashedStakeTotalAmount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"short","type":"uint256"},{"internalType":"uint256","name":"long","type":"uint256"}],"name":"updateGasPowerAllocationRate","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"withdrawDelegation","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"value","type":"uint256"}],"name":"updateBaseRewardPerSec","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[],"name":"prepareToWithdrawDelegation","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"delegationLockPeriodEpochs","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":true,"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"epochSnapshots","outputs":[{"internalType":"uint256","name":"endTime","type":"uint256"},{"internalType":"uint256","name":"duration","type":"uint256"},{"internalType":"uint256","name":"epochFee","type":"uint256"},{"internalType":"uint256","name":"totalBaseRewardWeight","type":"uint256"},{"internalType":"uint256","name":"totalTxRewardWeight","type":"uint256"},{"internalType":"uint256","name":"baseRewardPerSecond","type":"uint256"},{"internalType":"uint256","name":"stakeTotalAmount","type":"uint256"},{"internalType":"uint256","name":"delegationsTotalAmount","type":"uint256"},{"internalType":"uint256","name":"totalSupply","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"maxDelegatedRatio","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":true,"inputs":[],"name":"contractCommission","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":true,"inputs":[],"name":"delegationsTotalAmount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"internalType":"bytes","name":"metadata","type":"bytes"}],"name":"updateStakerMetadata","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"internalType":"uint256","name":"stakerID","type":"uint256"},{"internalType":"uint256","name":"epoch","type":"uint256"}],"name":"calcTotalReward","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"minStake","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":false,"inputs":[],"name":"updateCapReachedDate","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"unbondingUnlockPeriod","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":true,"inputs":[],"name":"stakeTotalAmount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"capReachedDate","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"stakeLockPeriodTime","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":true,"inputs":[],"name":"delegationsNum","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"unbondingStartDate","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":true,"inputs":[],"name":"stakeLockPeriodEpochs","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"addr","type":"address"}],"name":"getStakerID","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"bondedTargetRewardUnlock","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"unbondingPeriod","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":false,"inputs":[],"name":"renounceOwnership","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"currentEpoch","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"currentSealedEpoch","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"stakersLastID","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"rewardsAllowed","outputs":[{"internalType":"bool","name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"owner","outputs":[{"internalType":"address","name":"","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"isOwner","outputs":[{"internalType":"bool","name":"","type":"bool"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"uint256","name":"stakerID","type":"uint256"},{"internalType":"uint256","name":"_fromEpoch","type":"uint256"},{"internalType":"uint256","name":"maxEpochs","type":"uint256"}],"name":"calcValidatorRewards","outputs":[{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"stakerMetadata","outputs":[{"internalType":"bytes","name":"","type":"bytes"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"slashedDelegationsTotalAmount","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"validatorCommission","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":true,"inputs":[],"name":"maxStakerMetadataSize","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"delegator","type":"address"},{"internalType":"uint256","name":"_fromEpoch","type":"uint256"},{"internalType":"uint256","name":"maxEpochs","type":"uint256"}],"name":"calcDelegationRewards","outputs":[{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"uint256","name":"","type":"uint256"},{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[{"internalType":"uint256","name":"e","type":"uint256"},{"internalType":"uint256","name":"v","type":"uint256"}],"name":"epochValidator","outputs":[{"internalType":"uint256","name":"stakeAmount","type":"uint256"},{"internalType":"uint256","name":"delegatedMe","type":"uint256"},{"internalType":"uint256","name":"baseRewardWeight","type":"uint256"},{"internalType":"uint256","name":"txRewardWeight","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[],"name":"withdrawStake","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"internalType":"address","name":"","type":"address"}],"name":"delegations","outputs":[{"internalType":"uint256","name":"createdEpoch","type":"uint256"},{"internalType":"uint256","name":"createdTime","type":"uint256"},{"internalType":"uint256","name":"deactivatedEpoch","type":"uint256"},{"internalType":"uint256","name":"deactivatedTime","type":"uint256"},{"internalType":"uint256","name":"amount","type":"uint256"},{"internalType":"uint256","name":"paidUntilEpoch","type":"uint256"},{"internalType":"uint256","name":"toStakerID","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"to","type":"uint256"}],"name":"createDelegation","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":false,"inputs":[],"name":"prepareToWithdrawStake","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[],"name":"minStakeIncrease","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":false,"inputs":[{"internalType":"bytes","name":"metadata","type":"bytes"}],"name":"createStake","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":false,"inputs":[],"name":"increaseStake","outputs":[],"payable":true,"stateMutability":"payable","type":"function"},{"constant":true,"inputs":[{"internalType":"uint256","name":"stakerID","type":"uint256"},{"internalType":"uint256","name":"epoch","type":"uint256"},{"internalType":"uint256","name":"delegatedAmount","type":"uint256"}],"name":"calcDelegationReward","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":true,"inputs":[],"name":"delegationLockPeriodTime","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"pure","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"_fromEpoch","type":"uint256"},{"internalType":"uint256","name":"maxEpochs","type":"uint256"}],"name":"claimValidatorRewards","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":false,"inputs":[{"internalType":"address","name":"newOwner","type":"address"}],"name":"transferOwnership","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"internalType":"uint256","name":"stakerID","type":"uint256"},{"internalType":"uint256","name":"epoch","type":"uint256"}],"name":"calcValidatorReward","outputs":[{"internalType":"uint256","name":"","type":"uint256"}],"payable":false,"stateMutability":"view","type":"function"},{"constant":false,"inputs":[{"internalType":"uint256","name":"_fromEpoch","type":"uint256"},{"internalType":"uint256","name":"maxEpochs","type":"uint256"}],"name":"claimDelegationRewards","outputs":[],"payable":false,"stateMutability":"nonpayable","type":"function"},{"constant":true,"inputs":[{"internalType":"uint256","name":"","type":"uint256"}],"name":"stakers","outputs":[{"internalType":"uint256","name":"status","type":"uint256"},{"internalType":"uint256","name":"createdEpoch","type":"uint256"},{"internalType":"uint256","name":"createdTime","type":"uint256"},{"internalType":"uint256","name":"deactivatedEpoch","type":"uint256"},{"internalType":"uint256","name":"deactivatedTime","type":"uint256"},{"internalType":"uint256","name":"stakeAmount","type":"uint256"},{"internalType":"uint256","name":"paidUntilEpoch","type":"uint256"},{"internalType":"uint256","name":"delegatedMe","type":"uint256"},{"internalType":"address","name":"stakerAddress","type":"address"}],"payable":false,"stateMutability":"view","type":"function"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"},{"indexed":true,"internalType":"address","name":"stakerAddress","type":"address"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"}],"name":"CreatedStake","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"}],"name":"UpdatedStakerMetadata","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"newAmount","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"diff","type":"uint256"}],"name":"IncreasedStake","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"from","type":"address"},{"indexed":true,"internalType":"uint256","name":"toStakerID","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"amount","type":"uint256"}],"name":"CreatedDelegation","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"from","type":"address"},{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"reward","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"fromEpoch","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"untilEpoch","type":"uint256"}],"name":"ClaimedDelegationReward","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"reward","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"fromEpoch","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"untilEpoch","type":"uint256"}],"name":"ClaimedValidatorReward","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"}],"name":"PreparedToWithdrawStake","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"penalty","type":"uint256"}],"name":"WithdrawnStake","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"from","type":"address"},{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"}],"name":"PreparedToWithdrawDelegation","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"from","type":"address"},{"indexed":true,"internalType":"uint256","name":"stakerID","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"penalty","type":"uint256"}],"name":"WithdrawnDelegation","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"_capReachedDate","type":"uint256"}],"name":"ChangedCapReachedDate","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"value","type":"uint256"}],"name":"UpdatedBaseRewardPerSec","type":"event"},{"anonymous":false,"inputs":[{"indexed":false,"internalType":"uint256","name":"short","type":"uint256"},{"indexed":false,"internalType":"uint256","name":"long","type":"uint256"}],"name":"UpdatedGasPowerAllocationRate","type":"event"},{"anonymous":false,"inputs":[{"indexed":true,"internalType":"address","name":"previousOwner","type":"address"},{"indexed":true,"internalType":"address","name":"newOwner","type":"address"}],"name":"OwnershipTransferred","type":"event"}]')


// Assign contract functions to sfc variable
sfc = web3.ftm.contract(abi).at("0xfc00face00000000000000000000000000000000")
```

## Checking loading sfc has worked

```
// Sanity check
sfc.stakersNum() // if everything is all right, will return non-zero value
```

## Delegating


### Create Delegation

Delegate a certain number of FTM to a staker. Note that you can only delegate to one validator per address.

If you already have a delegation, then you have to eigher create a new address or withdraw previous delegation.

Delegation is applied in next epoch. First reward will be received after 2 epochs, if staker was in validators group.

`amount` is set in Wei. Minimum delegation is 1000000000000000000 Wei (1 FTM).

```
YOUR_ADDRESS = <address>
personal.unlockAccount(YOUR_ADDRESS, <password>, 60) // unlock account for 60 second
tx = sfc.createDelegation(<stakerID>, {from: YOUR_ADDRESS, value: "<amount>"})
```

#### Checks
- Staker must exist
- Staker is active: staker isn't a cheater, isn't pruned for being offline, didn't prepare to withdraw
- Delegated amount is greater or equal to `sfc.minDelegation()`
- No more than one delegation per address
- This address isn't a staker
- `Total amount of delegations to staker` is less or equal to `15.0` * `staker's stake amount`.

### Increase delegation stake

Currently it's not possible to increase delegation stake. Delegator may create a new address to create a new delegation.

### Claim Delegation Rewards

Claim rewards earned from delegating your stake.

- `from_epoch` is starting epoch from which rewards are claimed. If 0, then `last claimed epoch + 1`. If specified epoch higher than `last claimed epoch + 1`, then rewards lower `from_epoch` aren't claimable anymore. If not sure, always use 0!
- `max_epochs` is maximum number of epochs to claim rewards for (in one call). If you have rewards for many epochs, call method multiple times until all rewards are claimed. If not sure, use 40.

```
// check you have rewards:
sfc.calcDelegationRewards(YOUR_ADDRESS, 0, max_epochs) // returns: rewards amount, first claimed epoch, last claimed epoch
// claim rewards:
personal.unlockAccount(YOUR_ADDRESS, <password>, 60) // unlock account for 60 second
tx = sfc.claimDelegationRewards(0, max_epochs, {from: YOUR_ADDRESS}) // call multiple times if there's more rewards than max_epochs
```

#### Checks
- Delegator must exist
- Delegator isn't deactivated (i.e. didn't prepare to withdraw)
- Claimed at least one epoch
- Not claimed the same epoch twice
- Starting epoch isn't in future
- Rewards are unlocked: passed sfc.unbondingUnlockPeriod() seconds since it's true that sfc.bondedRatio() >= sfc.bondedTargetRewardUnlock()

### Request to withdraw delegated stake

Put in a request to withdraw delegated stake. After a number of seconds and epochs have passed since calling the function below, you will be able to call withdrawDelegation() successfully.

After calling this function, you won't be able to claim rewards anymore. Claim all the rewards before calling this function.

The validator's stake will be decreased in next epoch by amount of delegation.

```
personal.unlockAccount(YOUR_ADDRESS, <password>, 60) // unlock account for 60 second
tx = sfc.prepareToWithdrawDelegation({from: YOUR_ADDRESS})
```

#### Checks
- Delegator must exist
- Delegator isn't deactivated (i.e. didn't prepare to withdraw)

### Withdraw delegated stake

Withdraw delegated stake. Erases delegation object and withdraws delegated stake.

Note that a number of seconds and epochs must elaspe since `prepareToWithdrawDelegation` call.

If staker is a cheater (i.e. doublesigned in DAG), then delegation will be erased, but delegated stake won't be withdrawn (i.e. will be slashed).

```
personal.unlockAccount(YOUR_ADDRESS, <password>, 60) // unlock account for 60 second
tx = sfc.withdrawDelegation({from:YOUR_ADDRESS })
```

#### Checks
- Passed at least `sfc.delegationLockPeriodTime()` seconds since `prepareToWithdrawDelegation` was called
- Passed at least `sfc.delegationLockPeriodEpochs()` epochs since `prepareToWithdrawDelegation` was called

## Validator Staking

### Create Validator

Create a new validator (staker)

Minimum stake is 3175000000000000000000000 Wei (3,175,000 FTM)

```
// Create validator
personal.unlockAccount(YOUR_ADDRESS, "password", 60) // unlock account for 60 second
tx = sfc.createStake([], {from:YOUR_ADDRESS, value: "<amount>"}) // minimum 3,175,000 FTM required to stake
```

#### Checks
- Stake amount is greater or equal to `sfc.minStake()`
- This address isn't a staker
- This address isn't a delegator

### Increase Validator Stake

Increase stake by amount of sent FTM.

The new stake will be applied in next epoch.

```
// Create Staker
personal.unlockAccount(YOUR_ADDRESS, "password", 60) // unlock account for 60 second
tx = sfc.increaseStake({from:YOUR_ADDRESS, value: "<amount>"})
```

#### Checks
- Amount is greater or equal to `sfc.minStakeIncrease()`
- Staker exists
- Staker is active: staker isn't a cheater, isn't pruned for being offline, didn't prepare to withdraw

### Claim Validator rewards

Claim rewards earned from being a validator.

- `from_epoch` is starting epoch from which rewards are claimed. If 0, then `last claimed epoch + 1`. If specified epoch higher than `last claimed epoch + 1`, then rewards lower `from_epoch` aren't claimable anymore. If not sure, always use 0!
- `max_epochs` is maximum number of epochs to claim rewards for (in one call). If you have rewards for many epochs, call method multiple times until all rewards are claimed. If not sure, use 40.

```
YOUR_ID = sfc.getStakerID(YOUR_ADDRESS) // if 0, then staker doesn't exist, or SFC functions aren't initialized correctly
// check you have rewards:
sfc.calcValidatorRewards(YOUR_ID, 0, max_epochs) // returns: rewards amount, first claimed epoch, last claimed epoch
// claim rewards:
personal.unlockAccount(YOUR_ADDRESS, <password>, 60) // unlock account for 60 second
tx = sfc.claimValidatorRewards(0, max_epochs, {from: YOUR_ADDRESS}) // call multiple times if there's more rewards than max_epochs
```

#### Checks
- Staker must exist
- Claimed at least one epoch
- `First epoch to claim` > `last claimed epoch`
- Starting epoch isn't in future
- Rewards are unlocked: passed sfc.unbondingUnlockPeriod() seconds since it's true that sfc.bondedRatio() >= sfc.bondedTargetRewardUnlock()

### Request to withdraw stake

Put in a request to withdraw stake, can then call withdrawStake() function after enough seconds and epochs have passed.

After calling this function, validators won't be a validator in next epoch.

This call doesn't affect already earned rewards by delegators and staker.

```
personal.unlockAccount(YOUR_ADDRESS, "password", 60) // unlock account for 60 second
tx = sfc.prepareToWithdrawStake({from: YOUR_ADDRESS})
```

#### Checks
- Staker must exist
- Staker isn't deactivated (i.e. didn't prepare to withdraw)

### Withdraw Stake

After enough seconds and epochs have passed since calling PreparedToWithdrawStake(), you can call this function successfully.

After calling this function, you won't be able to claim rewards anymore. Claim all the rewards before calling this function.

This call doesn't affect already earned rewards by delegators.

If staker is a cheater (i.e. doublesigned in DAG), then staker will be erased, but delegated stake won't be withdrawn (i.e. will be slashed).

```
personal.unlockAccount(YOUR_ADDRESS, "password", 60) // unlock account for 60 second
tx = sfc.withdrawStake({from: YOUR_ADDRESS})
```

#### Checks
- Passed at least `sfc.stakeLockPeriodTime()` seconds since `prepareToWithdrawStake` was called
- Passed at least `sfc.stakeLockPeriodEpochs()` epochs since `prepareToWithdrawStake` was called
