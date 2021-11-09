### Creating a new account

First we need to set up a new account to receive funds in. It can be done in a UI wallet or using go-opera:

```
opera account new
```

Follow the prompts and supply the password, you will receive output;

```
Your new key was generated

Public address of the key:   0xAddress
Path of the secret key file:

- You can share your public address with anyone. Others need it to interact with you.
- You must NEVER share the secret key with anyone! The key controls access to your funds!
- You must BACKUP your key file! Without the key, it's impossible to access account funds!
- You must REMEMBER your password! Without the password, it's impossible to decrypt the key!
```

### Creating a new validator key

We have to create validator private key to sign consensus messages with. It can be done only using go-opera:

```
opera validator new
```

Follow the prompts and supply the password, you will receive output;

```
Your new key was generated

Public key:                  0xYourPubkey
Path of the secret key file:

- You can share your public key with anyone. Others need it to validate messages from you.
- You must NEVER share the secret key with anyone! The key controls access to your validator!
- You must BACKUP your key file! Without the key, it's impossible to operate the validator!
- You must REMEMBER your password! Without the password, it's impossible to decrypt the key!
```

### Create a validator in the SFC

#### Initializing the SFC

Follow instructions in [sfc.md](sfc.md).

#### Creating a validator

Create validator

- Insert the validator public key with **quotes** instead of "0xYourPubkey". Example: "0xc004b81423f875a056d31e8779e2e9fb88f63e826bbe25a15dd00327622828a951aa5f7cc7ffd027b34b25a53ab64d1fbf6ccc2685ef893f36f814ee0d6b90cc5f39"  
Ensure that you specify a correct public key, as it's impossible to change afterwards!

- Insert your address with **quotes** instead of "0xYourAddress". Example: "0xfE19B9Ae8b056eE11d20A8F530326a2C3b99ADca"  
This address will be used for validator authentication in smart contract (such as collecting rewards or voting in the Governance contract)

- Substitute validator self-stake amount in FTM instead of 500000.0

```
personal.unlockAccount("0xYourAddress", "password", 60) // make sure account is unlocked
tx = sfcc.createValidator("0xYourPubkey", {from:"0xYourAddress", value: web3.toWei("500000.0", "ftm")}) // 500000.0 FTM
```


Check the tx is confirmed
```
ftm.getTransactionReceipt(tx) 
```

When tx gets confirmed, should be non-zero
```
sfcc.getValidatorID("0xYourAddress")
```

### Startup as a validator

Follow instructions in [launch-validator.md](launch-validator.md).
