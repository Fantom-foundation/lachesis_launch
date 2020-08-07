# Staking and Delegating 

**Note**: All references to "staker" and "stakers" refer to "validating nodes" or "validators".

## Attach to your node 
Attach to your running node. You may need to specify your specific configuration.

```js
./lachesis attach
```

## Loading the sfc
First, you have to [initialize contract context](./README.md##init-SFC-contract-context)

```js
abi = PASTE_ABI_HERE
sfc.contract = web3.ftm.contract(abi).at("0xfc00face00000000000000000000000000000000")
```

The ABI of the latest SFC release `2.0.2-rc.1` is available at `./releases/sfc-abi-2.0.2-rc.1.json`.

## Checking loading sfc has worked

```js
// Sanity check
sfc.contract.stakersNum() // if everything is all right, will return non-zero value
```

## Delegating

### Create Delegation

Delegate a certain number of FTM to a staker.

- `toStakerID` is ID of staker which will receive the delegation.
- `amount` is set in Wei. Minimum delegation is 1000000000000000000 Wei (1 FTM).

```js
YOUR_ADDRESS = <address>
personal.unlockAccount(YOUR_ADDRESS, <password>, 60) // unlock account for 60 second
tx = sfc.contract.createDelegation(<toStakerID>, {from: YOUR_ADDRESS, value: "<amount>"})
```

#### Checks
- Staker must exist
- Staker is active: staker isn't a cheater, isn't pruned for being offline, didn't prepare to withdraw
- Delegated amount is greater or equal to `sfc.contract.minDelegation()`
- This address isn't a staker
- `Total amount of delegations to staker` is less or equal to `15.0` * `staker's stake amount`.

### Claim Delegation Rewards

Claim rewards earned from delegating your stake.

- `toStakerID` is ID of staker which received the delegation.
- `maxEpochs` is maximum number of epochs to claim rewards for. If not sure, use 100.

```js
// check you have rewards:
sfc.contract.calcDelegationRewards(YOUR_ADDRESS, toStakerID, 0, maxEpochs) // returns: rewards amount, first claimed epoch, last claimed epoch
// claim rewards:
personal.unlockAccount(YOUR_ADDRESS, <password>, 60) // unlock account for 60 second
tx = sfc.contract.claimDelegationRewards(maxEpochs, toStakerID, {from: YOUR_ADDRESS}) // call multiple times if there's more epochs than maxEpochs
```

#### Checks
- Delegation must exist
- Delegation isn't deactivated (i.e. didn't prepare to withdraw)
- Claimed at least one epoch
- Not claimed the same epoch twice
- Starting epoch isn't in future

### Request to withdraw delegated stake

Put in a request to withdraw delegated stake. After a number of seconds and epochs have passed since calling the function below, you will be able to call withdrawDelegation() successfully.

After calling this function, you won't be able to claim rewards anymore. Claim all the rewards before calling this function.

- `toStakerID` is ID of staker which received the delegation.

```js
personal.unlockAccount(YOUR_ADDRESS, <password>, 60) // unlock account for 60 second
tx = sfc.contract.prepareToWithdrawDelegation(toStakerID, {from: YOUR_ADDRESS})
```

#### Checks
- Delegation must exist
- Delegation isn't deactivated (i.e. didn't prepare to withdraw)

###  Withdraw delegated stake

Withdraw delegated stake. Erases delegation object and returns delegated stake.

Note that a number of seconds and epochs must elaspe since `prepareToWithdrawDelegation` call.

If staker is cheater (i.e. doublesigned), then delegation will be erased, but delegated stake won't be withdrawn (i.e. will be slashed).

- `toStakerID` is ID of staker which received the delegation.

```js
personal.unlockAccount(YOUR_ADDRESS, <password>, 60) // unlock account for 60 second
tx = sfc.contract.withdrawDelegation(toStakerID, {from:YOUR_ADDRESS })
```

#### Checks
- Passed at least `sfc.contract.delegationLockPeriodTime()` seconds since `prepareToWithdrawDelegation` was called
- Passed at least `sfc.contract.delegationLockPeriodEpochs()` epochs since `prepareToWithdrawDelegation` was called

## Validator Staking

### Create Validator

Create a new validator (staker)

Minimum stake is 3175000000000000000000000 Wei (3,175,000 FTM)

```js
// Create validator
personal.unlockAccount(YOUR_ADDRESS, "password", 60) // unlock account for 60 second
tx = sfc.contract.createStake("0x", {from:YOUR_ADDRESS, value: "<amount>"}) // minimum 3,175,000 FTM required to stake
```

#### Checks
- Stake amount is greater or equal to `sfc.contract.minStake()`
- This address isn't a staker
- This address isn't a delegator

### Increase Validator Stake

Increase stake by amount of sent FTM.

The new stake will be applied in next epoch.

```js
// Create Staker
personal.unlockAccount(YOUR_ADDRESS, "password", 60) // unlock account for 60 second
tx = sfc.contract.increaseStake({from:YOUR_ADDRESS, value: "<amount>"})
```

#### Checks
- Amount is greater or equal to `sfc.contract.minStakeIncrease()`
- Staker exists
- Staker is active: staker isn't a cheater, isn't pruned for being offline, didn't prepare to withdraw

### Claim Validator rewards

Claim rewards earned from being a validator.

- `maxEpochs` is maximum number of epochs to claim rewards for. If not sure, use 40.

```js
YOUR_ID = sfc.contract.getStakerID(YOUR_ADDRESS) // if 0, then staker doesn't exist, or SFC functions aren't initialized correctly
// check you have rewards:
sfc.contract.calcValidatorRewards(YOUR_ID, 0, maxEpochs) // returns: rewards amount, first claimed epoch, last claimed epoch
// claim rewards:
personal.unlockAccount(YOUR_ADDRESS, <password>, 60) // unlock account for 60 second
tx = sfc.contract.claimValidatorRewards(maxEpochs, {from: YOUR_ADDRESS}) // call multiple times if there's more epochs than maxEpochs
```

Specify maxEpochs=200 to claim rewards of 200 epochs at a time to avoid running out of gas.

#### Checks
- Staker must exist
- Claimed at least one epoch
- Not claimed the same epoch twice
- Starting epoch isn't in future

### Request to withdraw stake

Put in a request to withdraw stake, can then call withdrawStake() function after enough seconds and epochs have passed

```js
personal.unlockAccount(YOUR_ADDRESS, "password", 60) // unlock account for 60 second
tx = sfc.contract.prepareToWithdrawStake({from: YOUR_ADDRESS})
```

#### Checks
- Staker must exist
- Staker isn't deactivated (i.e. didn't prepare to withdraw)

### Withdraw Stake

After enough seconds and epochs have passed since calling preparedToWithdrawStake(), you can call this function successfully.

After calling this function, you won't be able to claim rewards anymore. Claim all the rewards before calling this function.

```js
personal.unlockAccount(YOUR_ADDRESS, "password", 60) // unlock account for 60 second
tx = sfc.contract.withdrawStake({from: YOUR_ADDRESS})
```

#### Checks
- Passed at least `sfc.contract.stakeLockPeriodTime()` seconds since `prepareToWithdrawStake` was called
- Passed at least `sfc.contract.stakeLockPeriodEpochs()` epochs since `prepareToWithdrawStake` was called
