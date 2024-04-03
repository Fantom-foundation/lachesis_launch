### Change key of a legacy validator

For legacy validators (IDs ≤ 59) on the Opera mainnet, it's recommended to update to a new validator key, securely removing the previous key from your server, and transferring the validator address key to an air-gapped or a secure device.

1. Generate new key with `opera --datadir /path/to/datadir validator new`. Ensure you create a robust password, do not save it on the machine, and instead enter it manually after every restart for enhanced security.
2. Backup the generated key!
3. Restart the node in a non-validating mode to prepare for the key update process.
4. Update the validator's public key by calling `sfcc.updateValidatorPubkey('0xNEWPUBKEY')` method in SFC. This can be done through the console (refer to [sfc.md](sfc.md)) by using a wallet that allows calling contract methods with a specific ABI, such as MEW with ([SFC ABI v3](../releases/sfc-abi-3.0.5-rc.1.json))
5. Restart the node in validator mode, specifying the new public key with the `--validator.pubkey` argument
6. Securely delete the old key file using: `shred -vu /path/to/datadir/keystore/validator/oldkey`. If a password file was stored on the server, remove it using `shred -vu`. Additionally, if the validator address key (can be found in `/path/to/datadir/keystore/`) was saved on the server, transfer it to an air-gapped device for better security and then erase any traces of it from the server with `shred -vu`.

The motivation for this procedure is that in `go-lachesis` the same key was used for both the validator address key (utilized for operations in SFC) and the validator key (employed in the creation of events). Following this procedure will ensure that if attacker gains access to only validator key, he won't be able to access funds in SFC.
