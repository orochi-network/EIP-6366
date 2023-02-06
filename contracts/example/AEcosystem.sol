// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import './APermissioned.sol';

contract AEcosystem is APermissioned {
  constructor(address _permsionToken) APermissioned(_permsionToken) {
    // Constructor code
  }

  function createProposal(address _permissionOwner) external allow(_permissionOwner, PERMISSION_CREATE) notBlacklisted {
    // Only allow owner or delegatee with PERMISSION_CREATE
  }

  function vote() external allowOwner(PERMISSION_VOTE) notBlacklisted {
    // Only allow permission owner with PERMISSION_VOTE
  }

  function execute() external allowOwner(ROLE_OPERATOR) notBlacklisted {
    // Only allow permission owner with ROLE_OPERATOR
  }

  function stopProposal() external allowOwner(ROLE_ADMIN) notBlacklisted {
    // Only allow permission owner with ROLE_ADMIN
  }

  function register() external notBlacklisted {
    // Permission Token is not only provide the ability to whitelist an address
    // but also provide the ability to blacklist an address.
    // In this case, blacklisted address wont able to register
  }
}
