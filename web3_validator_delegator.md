# Staking and Delegating (Work in Progress)

**Note**: All references to "staker" and "stakers" refer to "validating nodes".


## Loading the sfc
First, you have to [initialize contract context](./README.md##init-SFC-contract-context)


## Checking loading sfc has worked

```
// Sanity check
sfc.stakersNum() // if everything is all right, will return non-zero value
```

## Delegating


### Create Delegation

Delegate a certain number of FTM to a staker. Note that you can only delegate to one validator per address.

If you already have a delegation, then you have to eigher create a new address or withdraw previous delegation.

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

### Claim Delegation Rewards

Claim rewards earned from delegating your stake.

- `from_epoch` is starting epoch from which rewards are claimed. If 0, then last claimed epoch + 1. If not sure, always use 0.
- `max_epochs` is maximum number of epochs to claim rewards for. If not sure, use 40.

```
// check you have rewards:
sfc.calcDelegationRewards(YOUR_ADDRESS, from_epoch, max_epochs) // returns: rewards amount, first claimed epoch, last claimed epoch
// claim rewards:
personal.unlockAccount(YOUR_ADDRESS, <password>, 60) // unlock account for 60 second
tx = sfc.claimDelegationRewards(from_epoch, max_epochs, {from: YOUR_ADDRESS}) // call multiple times if there's more epochs than max_epochs
```

#### Checks
- Delegator must exist
- Delegator isn't deactivated (i.e. didn't prepare to withdraw)
- Claimed at least one epoch
- Not claimed the same epoch twice
- Starting epoch isn't in future

### Request to withdraw delegated stake

Put in a request to withdraw delegated stake. After a number of seconds and epochs have passed since calling the function below, you will be able to call withdrawDelegation() successfully.

After calling this function, you won't be able to claim rewards anymore. Claim all the rewards before calling this function.

```
personal.unlockAccount(YOUR_ADDRESS, <password>, 60) // unlock account for 60 second
tx = sfc.prepareToWithdrawDelegation({from: YOUR_ADDRESS})
```

#### Checks
- Delegator must exist
- Delegator isn't deactivated (i.e. didn't prepare to withdraw)

###  Withdraw delegated stake

Withdraw delegated stake. Erases delegation object and returns delegated stake.

Note that a number of seconds and epochs must elaspe since `prepareToWithdrawDelegation` call.

If staker is cheater (i.e. doublesigned), then delegation will be erased, but delegated stake won't be withdrawn (i.e. will be slashed).

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

- `from_epoch` is starting epoch from which rewards are claimed. If 0, then last claimed epoch + 1. If not sure, always use 0.
- `max_epochs` is maximum number of epochs to claim rewards for. If not sure, use 40.

```
YOUR_ID = sfc.getStakerID(YOUR_ADDRESS) // if 0, then staker doesn't exist, or SFC functions aren't initialized correctly
// check you have rewards:
sfc.calcValidatorRewards(YOUR_ID, from_epoch, max_epochs) // returns: rewards amount, first claimed epoch, last claimed epoch
// claim rewards:
personal.unlockAccount(YOUR_ADDRESS, <password>, 60) // unlock account for 60 second
tx = sfc.claimValidatorRewards(from_epoch, max_epochs, {from: YOUR_ADDRESS}) // call multiple times if there's more epochs than max_epochs
```

#### Checks
- Staker must exist
- Claimed at least one epoch
- Not claimed the same epoch twice
- Starting epoch isn't in future

### Request to withdraw stake

Put in a request to withdraw stake, can then call withdrawStake() function after enough seconds and epochs have passed

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

```
personal.unlockAccount(YOUR_ADDRESS, "password", 60) // unlock account for 60 second
tx = sfc.withdrawStake({from: YOUR_ADDRESS})
```

#### Checks
- Passed at least `sfc.stakeLockPeriodTime()` seconds since `prepareToWithdrawStake` was called
- Passed at least `sfc.stakeLockPeriodEpochs()` epochs since `prepareToWithdrawStake` was called
