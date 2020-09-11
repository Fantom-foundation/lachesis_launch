# Validator Staking
**Note**: All references to "staker" and "stakers" refer to "validating nodes" or "validators".

## Loading the sfc

### Attach to your node 
Attach to your running node. You may need to specify your specific configuration.

```
./lachesis attach
```

### Loading the sfc
First, you have to [initialize contract context](./README.md##init-SFC-contract-context)

```
abi = JSON.parse('...')
// Note: define variable sfcc (instead of sfc) to avoid clashing with the sfc namespace introduced in go-lachesis v0.7.0-rc1.
sfcc = web3.ftm.contract(abi).at("0xfc00face00000000000000000000000000000000")
```

The current sfc release is `2.0.2-rc2`. The ABI output available at `./releases/sfc-abi-2.0.2-rc.2.json`.


### Checking loading sfc has worked

```
// Sanity check
sfcc.stakersNum() // if everything is all right, will return non-zero value
```

## Validator Staking

### Create Validator

Create a new validator (staker)

Minimum stake is 3175000000000000000000000 Wei (3,175,000 FTM)

```
// Create validator
personal.unlockAccount(YOUR_ADDRESS, "password", 60) // unlock account for 60 second
tx = sfcc.createStake([], {from:YOUR_ADDRESS, value: "<amount>"}) // minimum 3,175,000 FTM required to stake
```

#### Checks
- Stake amount is greater or equal to `sfcc.minStake()`
- This address isn't a staker
- This address isn't a delegator

### Increase Validator Stake

Not available since sfc2.0.2-rc2.

### Claim Validator rewards

Claim rewards earned from being a validator.

- `from_epoch` is starting epoch from which rewards are claimed. If 0, then last claimed epoch + 1. If not sure, always use 0.
- `max_epochs` is maximum number of epochs to claim rewards for. If not sure, use 40.

```
YOUR_ID = sfcc.getStakerID(YOUR_ADDRESS) // if 0, then staker doesn't exist, or SFC functions aren't initialized correctly
// check you have rewards:
sfcc.calcValidatorRewards(YOUR_ID, from_epoch, max_epochs) // returns: rewards amount, first claimed epoch, last claimed epoch
// claim rewards:
personal.unlockAccount(YOUR_ADDRESS, <password>, 60) // unlock account for 60 second
tx = sfcc.claimValidatorRewards([max_epochs], {from: YOUR_ADDRESS}) // call multiple times if there's more epochs than max_epochs
```

There are two ways to claim rewards. `claimValidatorCompoundRewards` will add rewards into the current stake. `claimValidatorRewards` will place rewards into the account's available balance.

Specify max_epochs=200 to claim rewards of 200 epochs at a time to avoid running out of gas.

#### Checks
- Staker must exist
- Claimed at least one epoch
- Not claimed the same epoch twice
- Starting epoch isn't in future

### Request to withdraw stake

Put in a request to withdraw stake, can then call `withdrawStake()` function after enough seconds and epochs have passed

```
personal.unlockAccount(YOUR_ADDRESS, "password", 60) // unlock account for 60 second
tx = sfcc.prepareToWithdrawStake({from: YOUR_ADDRESS})
```

#### Checks
- Staker must exist
- Staker isn't deactivated (i.e. didn't prepare to withdraw)

### Request to partially withdraw validator stake

To partially withdraw stake. This function can only be called after all the rewards are claimed (rewards may be claimed even if they're locked). Pay attention that proportional part of stashed rewards will be burned within this call, due to penalty for early withdrawal.

After calling partially withdrawing stake for a number of seconds and epochs, you will be able to call `withdrawByRequest()` successfully.

`request ID` is any number which wasn't used by this validator previously.
Remember this number, it'll be needed to finalize withdrawal. Use `0` if not sure.

Validator cannot leave less stake than `minStake()` or less than `delegations amount` * `15.0`.

This call doesn't affect already earned rewards by delegators.

The validator's stake will be decreased in next epoch by `amount`.

```js
sfcc.prepareToWithdrawStakePartial(`request ID`, web3.toWei(`amount to withdraw`, "ftm"), {from: `address`})
```

#### Checks
- Staker must exist
- All staker rewards are claimed
- Staker isn't deactivated (i.e. didn't prepare to withdraw)
- request ID isn't occupied by another request
- `amount to withdraw` >= `minStakeDecrease()`
- `left amount` >= `minStake()`
- `left amount` >= `delegations amount` * `15.0`


### Partially withdraw stake

To finalize withdrawal request, wait for number of seconds and epochs must elaps since `prepareToWithdrawStakePartial` call. Erases request object and withdraws requested stake, transfers requested stake to account address.

If staker is a cheater (i.e. double-signed), then object will be erased, but stake won't be withdrawn (i.e. will be slashed).

```js
sfcc.withdrawByRequest(`request ID`, {from: `address`})
```

#### Checks
- Passed at least `sfcc.stakeLockPeriodTime()` seconds since `prepareToWithdrawStakePartial`
- Passed at least `sfcc.stakeLockPeriodEpochs()` epochs since `prepareToWithdrawStakePartial`



### Fully withdraw stake

Validator can call `prepareToWithdrawStake` to prepare to withdraw their stake fully. It only applies if the stake is not locked (lockup has expired), or validator is offline.

```js
sfcc.prepareToWithdrawStake({from: address})
````


After enough seconds and epochs have passed since calling `prepareToWithdrawStake()`, validator can call this function successfully.

If staker is a cheater (i.e. double-signed), then staker will be erased, but delegated stake won't be withdrawn (i.e. will be slashed).

```js
sfcc.withdrawStake({from: `address`})
```

#### Checks
- Passed at least `sfcc.stakeLockPeriodTime()` seconds since `prepareToWithdrawStake` was called
- Passed at least `sfcc.stakeLockPeriodEpochs()` epochs since `prepareToWithdrawStake` was called

### Lock up stake

Reward for a non-locked stake is 30% (base rate) of the full reward for a locked stake.
It is impossible to withdraw stake until lockup period has expired.

```js
sfcc.lockUpStake(`lockup duration`, {from: `address`})
```

`lockup duration` is lockup duration in seconds. Must be >= 14 days, <= 365 days.

#### Checks
- `lockup duration` >= 14 days
- `lockup duration` <= 365 days