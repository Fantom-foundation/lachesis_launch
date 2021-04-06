## First steps

### Attach to your node 
Attach to a running node. You may need to specify your specific configuration.

```
lachesis attach
```

### Loading the sfc
First, you have to [initialize contract context](./README.md#init-SFC-contract-context)

```js
abi = JSON.parse('SFC_ABI_OUTPUT')
// Note: define variable sfcc (instead of sfc) to avoid clashing with the sfc namespace introduced in go-lachesis v0.7.0-rc1.
sfcc = web3.ftm.contract(abi).at("0xfc00face00000000000000000000000000000000")
```

The current sfc release is `2.0.4-rc2`. The ABI output available at [SFC 2.0.4-rc2](./releases/sfc-abi-2.0.4-rc.2.json).

### Checking loading sfc has worked

```js
// Sanity check
sfcc.stakersNum() // if everything is all right, will return non-zero value
```

### Unlocking account

```js
personal.unlockAccount(YOUR_ADDRESS, "password", 60)
```

## Validator operations

**Note**: All references to "staker" and "stakers" refer to "validating nodes" or "validators".

https://github.com/Fantom-foundation/fantom-sfc/wiki/Validator-calls-reference
