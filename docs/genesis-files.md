## Mainnet genesis files

#### Epoch 171200, block 50870730

Genesis files below can be processed only with go-opera v1.1.2-rc.5 or later.

|                                             Name                                           | Fullsync | Snapsync | Blocks history | Starting EVM history |   Size   |
|:------------------------------------------------------------------------------------------:|:--------:|:--------:|:--------------:|:--------------------:|:--------:|
| [mainnet-171200-no-history.g](https://files.fantom.network/mainnet-171200-no-history.g)    | No       | Yes      | 43801590+      | No                   | 20 GB    |
| [mainnet-171200-pruned-mpt.g](https://files.fantom.network/mainnet-171200-pruned-mpt.g)    | Yes      | Yes      | Full           | Pruned (one block)   | 122 GB   |

#### Epoch 109331, block 37676547

|                                             Name                                           | Fullsync | Snapsync | Blocks history | Starting EVM history |   Size   |
|:------------------------------------------------------------------------------------------:|:--------:|:--------:|:--------------:|:--------------------:|:--------:|
| [mainnet-109331-no-history.g](https://download.fantom.network/mainnet-109331-no-history.g) | No       | Yes      | 37676547+      | No                   | 16.3 KB  |
| [mainnet-109331-no-mpt.g](https://download.fantom.network/mainnet-109331-no-mpt.g)         | No       | Yes      | Full           | No                   | 58.3 GB  |
| [mainnet-109331-pruned-mpt.g](https://download.fantom.network/mainnet-109331-pruned-mpt.g) | Yes      | Yes      | Full           | Pruned (one block)   | 78.1 GB  |
| [mainnet-109331-full-mpt.g](https://download.fantom.network/mainnet-109331-full-mpt.g)     | Yes      | Yes      | Full           | Full                 | 3.1 TB   |

#### Epoch 5577, block 4564025

|                                             Name                                           | Fullsync | Snapsync | Blocks history | Starting EVM history |   Size   |
|:------------------------------------------------------------------------------------------:|:--------:|:--------:|:--------------:|:--------------------:|:--------:|
| [mainnet-5577-pruned-mpt.g](https://download.fantom.network/mainnet-5577-pruned-mpt.g)     | Yes      | No       | Full           | Pruned (one block)   | 1.1 GB   |
| [mainnet-5577-full-mpt.g](https://download.fantom.network/mainnet-5577-full-mpt.g)         | Yes      | No       | Full           | Full                 | 30.4 GB  |

## Public testnet genesis files

#### Epoch 16200, block 12262196

Genesis files below can be processed only with go-opera v1.1.2-rc.5 or later.

|                                             Name                                           | Fullsync | Snapsync | Blocks history | Starting EVM history |   Size   |
|:------------------------------------------------------------------------------------------:|:--------:|:--------:|:--------------:|:--------------------:|:--------:|
| [testnet-16200-no-history.g](https://files.fantom.network/testnet-16200-no-history.g)      | No       | Yes      | 7650765+       | No                   | 1.5 GB   |
| [testnet-16200-no-mpt.g](https://files.fantom.network/testnet-16200-no-mpt.g)              | No       | Yes      | Full           | No                   | 3.3 GB   |
| [testnet-16200-pruned-mpt.g](https://files.fantom.network/testnet-16200-pruned-mpt.g)      | Yes      | Yes      | Full           | Pruned (one block)   | 5.5 GB   |
| [testnet-16200-full-mpt.g](https://files.fantom.network/testnet-16200-full-mpt.g)          | Yes      | Yes      | Full           | Full                 | 116 GB   |

#### Epoch 6226, block 7650765

|                                             Name                                           | Fullsync | Snapsync | Blocks history | Starting EVM history |   Size   |
|:------------------------------------------------------------------------------------------:|:--------:|:--------:|:--------------:|:--------------------:|:--------:|
| [testnet-6226-no-history.g](https://download.fantom.network/testnet-6226-no-history.g)     | No       | Yes      | 7650765+       | No                   | 1.7 KB   |
| [testnet-6226-no-mpt.g](https://download.fantom.network/testnet-6226-no-mpt.g)             | No       | Yes      | Full           | No                   | 2.0 GB   |
| [testnet-6226-pruned-mpt.g](https://download.fantom.network/testnet-6226-pruned-mpt.g)     | Yes      | Yes      | Full           | Pruned (one block)   | 3.2 GB   |
| [testnet-6226-full-mpt.g](https://download.fantom.network/testnet-6226-full-mpt.g)         | Yes      | Yes      | Full           | Full                 | 76.5 GB  |

#### Epoch 2458, block 479326

|                                             Name                                           | Fullsync | Snapsync | Blocks history | Starting EVM history |   Size   |
|:------------------------------------------------------------------------------------------:|:--------:|:--------:|:--------------:|:--------------------:|:--------:|
| [testnet-2458-pruned-mpt.g](https://download.fantom.network/testnet-2458-pruned-mpt.g)     | Yes      | No       | Full           | Pruned (one block)   | 81.5 MB  |
| [testnet-2458-full-mpt.g](https://download.fantom.network/testnet-2458-full-mpt.g)         | Yes      | No       | Full           | Full                 | 977.7 MB |

## FAQ

> What does "Fullsync = Yes" and "Fullsync = No" mean?
- "Fullsync = Yes" means that this genesis file can be used with `--syncmode full` (default)
- "Snapsync = Yes" means that this genesis file can be used with `--syncmode snap`
- If it has Yes in both columns, then it can be used with either mode

> Can I remove genesis file after node in initialized?
- Once genesis file is processed, it can be removed from disk. `--genesis` flag is no longer mandatory for initialized datadirs.

> If I use snapsync node with not full blocks history, what will be the lowest accesible block via API?
- Snapsync downloads all block records higher than highest genesis block. For example, after syncing up with `mainnet-109331-no-history.g`, all blocks will be accessible starting from 37676547.
  For genesis `mainnet-109331-no-mpt.g`, all blocks will be accessible via API.

> What genesis file should be used for archive API node?
- Archive node has to use fullsync mode with any genesis file which has Full in column "Starting EVM history"

> What genesis file should be used for validator node?
- Validator node has to use fullsync mode with any genesis file which supports fullsync
