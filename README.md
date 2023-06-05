# gasless-uniswap
With the use of the Sequence Builder, one can sponsor the transactions for the uniswap transactions, to allow for swaps free from gas for either a particular project or token (implemented), or, any token.

# steps
1. *deploy contract* that wraps uniswap v3 router (can update swap targets in example, or, can be contract addresses that are passed in, that match some subset of tokens)
2. *using Sequence Builder add contract address* to the list of sponsored addresses in the gas tank
3. *test* with a frontend using a sequence wallet

## todo
- smart contract error