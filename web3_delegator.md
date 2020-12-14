# Delegating 
**Note**: All references to "staker" and "stakers" refer to "validating nodes" or "validators".

## Loading the sfc

### Attach to your node 
Attach to your running node. You may need to specify your specific configuration.

```
./lachesis attach
```

### Loading the sfc
First, you have to [initialize contract context](./README.md##init-SFC-contract-context)

```js
abi = JSON.parse('...')
// Note: define variable sfcc (instead of sfc) to avoid clashing with the sfc namespace introduced in go-lachesis v0.7.0-rc1.
sfcc = web3.ftm.contract(abi).at("0xfc00face00000000000000000000000000000000")
```

The current sfc release is `2.0.4-rc2`. The ABI output available at `./releases/sfc-abi-2.0.4-rc.2.json`.


### Checking loading sfc has worked

```js
// Sanity check
sfcc.stakersNum() // if everything is all right, will return non-zero value
```

## Delegating


### Create Delegation

Delegate a certain number of FTM to a staker. Note that you can only delegate to one validator per address.

If you already have a delegation, then you have to either create a new address or withdraw previous delegation.

`amount` is set in Wei. Minimum delegation is 1000000000000000000 Wei (1 FTM).

```js
YOUR_ADDRESS = <address>
personal.unlockAccount(YOUR_ADDRESS, <password>, 60) // unlock account for 60 second
tx = sfcc.createDelegation(<stakerID>, {from: YOUR_ADDRESS, value: "<amount>"})
```

#### Checks
- Staker must exist
- Staker is active: staker isn't a cheater, isn't pruned for being offline, didn't prepare to withdraw
- Delegated amount is greater or equal to `sfcc.minDelegation()`
- No more than one delegation per address
- This address isn't a staker
- `Total amount of delegations to staker` is less or equal to `15.0` * `staker's stake amount`.

### Increase delegation stake

Not available since sfc2.0.2-rc2.

### Claim Delegation Rewards

Claim rewards earned from delegating your stake.

- `from_epoch` is starting epoch from which rewards are claimed. If 0, then last claimed epoch + 1. If not sure, always use 0.
- `max_epochs` is maximum number of epochs to claim rewards for. If not sure, use 40.

```js
// check you have rewards:
sfcc.calcDelegationRewards(YOUR_ADDRESS, from_epoch, max_epochs) // returns: rewards amount, first claimed epoch, last claimed epoch
// claim rewards:
personal.unlockAccount(YOUR_ADDRESS, <password>, 60) // unlock account for 60 second
tx = sfcc.claimDelegationRewards([max_epochs], {from: YOUR_ADDRESS}) // call multiple times if there's more epochs than max_epochs
```

There are two ways to claim rewards. `claimDelegationCompoundRewards` will add rewards into the current delegation. `claimDelegationRewards` will place rewards into the account's available balance.

Specify max_epochs=200 to claim rewards of 200 epochs at a time to avoid running out of gas.

#### Checks
- Delegator must exist
- Delegator isn't deactivated (i.e. didn't prepare to withdraw)
- Claimed at least one epoch
- Not claimed the same epoch twice
- Starting epoch isn't in future

### Request to fully withdraw delegated stake

Put in a request to withdraw delegated stake. After a number of seconds and epochs have passed since calling the function below, you will be able to call `withdrawDelegation()` successfully.

After calling this function, you won't be able to claim rewards anymore. Claim all the rewards before calling this function.

Pay attention that stashed rewards will be burned within this call, unless delegator called this function AFTER validator has prepared to withdraw.

The validator's stake will be decreased in next epoch by amount of delegation.

```js
personal.unlockAccount(YOUR_ADDRESS, <password>, 60) // unlock account for 60 second
tx = sfcc.prepareToWithdrawDelegation(staker_id, {from: YOUR_ADDRESS})
```

#### Checks
- Delegation must exist
- All delegation rewards are claimed
- Delegation isn't deactivated (i.e. didn't prepare to withdraw)


### Request to partially withdraw delegated stake

Put in a request to partially withdraw delegated stake. This function can be callled after all the rewards are claimed (rewards may be claimed even if they're locked). Locked rewards that are claimed are stashed until they are unlocked.
After a number of seconds and epochs have passed since calling the function below, you will be able to call `withdrawByRequest()` successfully.


**The proportional part of stashed rewards will be burned within this call, unless delegator called this function AFTER validator has prepared to withdraw**.

`request ID` is any number which wasn't used by delegator before.
Remember this number, it'll be needed to finalize withdrawal. Use `0` if not sure.

Delegator cannot prepare to withdraw the whole stake with this call. Use `prepareToWithdrawDelegation` for this case.

The validator's stake will be decreased in next epoch by `amount to withdraw`.

```js
sfcc.prepareToWithdrawDelegationPartial(`request ID`, `stakerID`, web3.toWei(`amount to withdraw`, "ftm"), {from: `address`})
```

#### Checks
- Delegation must exist
- All delegation rewards are claimed
- Delegation isn't deactivated (i.e. didn't prepare to withdraw)
- request ID isn't occupied by another request
- `amount to withdraw` >= `minDelegationDecrease()`
- `left amount` >= `minDelegation()`


###  Fully Withdraw delegated stake

Withdraw delegated stake. Erases delegation object and returns delegated stake.

Note that a number of seconds and epochs must elaspe since `prepareToWithdrawDelegation` call.

If staker is a cheater (i.e. double-signed), then delegation will be erased, but delegated stake won't be withdrawn (i.e. will be slashed).

```js
personal.unlockAccount(YOUR_ADDRESS, <password>, 60) // unlock account for 60 second
tx = sfcc.withdrawDelegation({from:YOUR_ADDRESS })
```

#### Checks
- Either passed at least `sfcc.delegationLockPeriodTime()` seconds since `prepareToWithdrawDelegation` was called, or validator has withdrawn already
- Either passed at least `sfcc.delegationLockPeriodEpochs()` epochs since `prepareToWithdrawDelegation` was called, or validator has withdrawn already


### Partially withdraw delegated stake

Finalize withdrawal request. Erases request object and withdraws requested stake, transfers requested stake to account address.

Note that a number of seconds and epochs must elapse since `prepareToWithdrawDelegationPartial` call.

If staker is a cheater (i.e. double-signed), then object will be erased, but stake won't be withdrawn (i.e. will be slashed).

```js
sfcc.withdrawByRequest(`request ID`, {from: `address`})
```

#### Checks
- Either passed at least `sfcc.delegationLockPeriodTime()` seconds since `prepareToWithdrawDelegationPartial` was called, or validator has withdrawn already
- Either passed at least `sfcc.delegationLockPeriodEpochs()` epochs since `prepareToWithdrawDelegationPartial` was called, or validator has withdrawn already

### Lock up delegation

Reward for a non-locked stake is 30% (base rate) of the full reward for a locked stake.
If withdrawal is to be made before lockup period expired, the following penalty will be withheld from the withdrawn amount:
- 85% of rewards received for epochs during the lockup period. On partial withdrawal, the penalty is multiplied by a ratio of withdrawn stake (in a case of withdrawing a half of stake, 85%/2=42.5% penalty is applied). 85% is the penalty calculated as (base rate = 30%)/2 + lockup rate = 70%.

Note that validator's stake must be locked up before validator's delegations can lock their stake. The specified lockup period of a delegation must not exceed the validator's current lockup period.

```js
sfcc.lockUpDelegation(`lockup duration`, `stakerID`, {from: `address`})
```

`lockup duration` is lockup duration in seconds. Must be >= 14 days, <= 365 days.

#### Checks
- Previous lockup period (if any) must end before the new period starts.
- lockup duration - lockup duration in seconds. Must be >= 14 days, <= 365 days.
- Validator's lockup period must end after delegation's lockup period will expire.

