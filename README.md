```text
eip: 6366
title: Permission Token
description: A new token that held the permission of an address in an ecosystem
author: Chiro (@chiro-hiro), Victor Dusart (@vdusart)
discussions-to: https://ethereum-magicians.org/t/eip-6366-a-standard-for-permission-token/9105
```

This repo implements the EIP-6366 and couple examples

## Abstract

This EIP offers an alternative to Access Control Lists (ACLs) for granting authorization and enhancing security. Each permission is represented by a single bit in `uint256` from which we can defined up to `256` permissions and `2²⁵⁶` roles. This approach use bitwise operator and bitmask to determine the access right which is much more efficient and flexible than `string` comparison or `keccak()`. We are able to specify the importance of permission based on the bit order.

## Motivation

Special roles like `Owner`, `Operator`, `Manager`, `Validator` are common for many smart contracts because permissioned addresses are used to administer and manage them. It is difficult to audit and maintain these system since these permissions are not managed in a single smart contract.

Since permission and role are reflected by the permission token balance of the relevant account in the given ecosystem, cross-interactivity between many ecosystems will be made simpler.

## License

All source code in `./contracts/` were licensed under [MIT License](./LICENSE)
