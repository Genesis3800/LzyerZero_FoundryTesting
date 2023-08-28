# Foundry tests for LayerZero contracts using a mock Endpoint

LayerZero is an omnichain omnichain interoperability protocol.
The protocol consists of a crucial off-chain component, called a *relayer*.
This piece of technology is responsible for transferring messages across chains. 

This however makes it difficult to test smart contracts on a local blockchain instance like Anvil, Hardhat node, Ganache.

The LayerZero team however provides a [mock endpoint](https://github.com/LayerZero-Labs/solidity-examples/blob/main/contracts/mocks/LZEndpointMock.sol "mock endpoint") that can be used to simulate cross-chain communication using a single blockchain.

This repo was built as an exercise in learning to figure out how to use the mock endpoint to write tests in Foundry.

## Overview

The OmniCounter project consists of:

- **OmniCounter_Sepolia.sol**: A contract deployed on the Sepolia testnet.
- **OmniCounter_Mumbai.sol**: A contract deployed on the Mumbai testnet.
- **OmniCounter.t.sol**: A test contract to ensure the functionality and interoperability of the above contracts.

The main functionality revolves around incrementing a counter on one chain and observing the corresponding increment on the other chain, showcasing real-time cross-chain communication.

## How to use

> Note that you will need to have Foundry installed in your system. Refer to [Foundry book](https://book.getfoundry.sh/ "Foundry book") for relevent instructions.

To use, Simply, clone the repo, and then:

1. To compile the contracts:

```bash
forge build
```

2. To run the tests:

```bash
forge test --match-path test/OmniCounter.t.sol -vvvv
```


>The verbosity flag(-v) is set to maximum to output the stack trace for all the calls happening in the test functions. Helpful for debugging.  
