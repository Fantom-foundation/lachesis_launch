## Launch a testing private network

Check the instruction for operating a private testing network (fakenet) there:
https://github.com/Fantom-foundation/go-opera/tree/63b18defec34fe698430268aa763658368922749#operating-a-private-network-fakenet

Also check out the demo scripts for fakenet: https://github.com/Fantom-foundation/go-opera/tree/63b18defec34fe698430268aa763658368922749/demo

All the instructions for Opera mainnet/testnet will apply to the fakenet with
the only exception that you have to use `--fakenet i/N` flag instead of `--genesis $NETWORK`.

## Launch a production private network

Launching a production private network involves generation of a custom genesis file.

Once genesis file is in place, all the instructions for Opera mainnet/testnet will apply to your private network with
the only exception that users have to use the custom genesis file instead of Opera mainnet or testnet genesis files.

Currently, there's no tool for generation of a go-opera genesis file. If you're looking to implement one yourself,
check out the functions https://github.com/Fantom-foundation/go-opera/blob/9f7c98f501143b5775a34796b34c9495473bf8d1/opera/genesisstore/dump.go#L71 and
https://github.com/Fantom-foundation/go-opera/blob/9f7c98f501143b5775a34796b34c9495473bf8d1/integration/makegenesis/genesis.go#L44.
