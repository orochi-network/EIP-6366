// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import '../ERC6366/interfaces/IERC6366Core.sol';
import '../ERC6366/interfaces/IERC6366Error.sol';

/**
 * @dev Centralized definition of all possible permissions and roles
 */
contract APermissioned is IERC6366Error {
  IERC6366Core private opt;

  /**
   * @dev No permission
   */
  uint256 internal constant PERMISSION_NONE = 0;

  /**
   * @dev Blacklisted
   */
  uint256 internal constant PERMISSION_DENIED = 2 ** 0;

  /**
   * @dev Permission to vote
   */
  uint256 internal constant PERMISSION_VOTE = 2 ** 1;

  /**
   * @dev Permission to transfer permission token
   */
  uint256 internal constant PERMISSION_TRANSFER = 2 ** 2;

  /**
   * @dev Permission to execute
   */
  uint256 internal constant PERMISSION_EXECUTE = 2 ** 3;

  /**
   * @dev Permission to create
   */
  uint256 internal constant PERMISSION_CREATE = 2 ** 4;

  /**
   * @dev Admin role
   */
  uint256 internal constant ROLE_ADMIN = PERMISSION_VOTE | PERMISSION_EXECUTE | PERMISSION_CREATE;

  /**
   * @dev Operator role
   */
  uint256 internal constant ROLE_OPERATOR = PERMISSION_EXECUTE | PERMISSION_VOTE;

  /**
   * @dev Allow the actor who has required permission
   */
  modifier allowOwner(uint256 _required) {
    if (!opt.permissionRequire(_required, opt.permissionOf(msg.sender))) {
      revert AccessDenied(msg.sender, msg.sender, _required);
    }
    _;
  }

  /**
   * @dev Deny blacklisted address
   */
  modifier denyOwner() {
    if (opt.permissionRequire(PERMISSION_DENIED, opt.permissionOf(msg.sender))) {
      revert AccessDenied(msg.sender, msg.sender, PERMISSION_DENIED);
    }
    _;
  }

  /**
   * @dev Allow permission owner or delegatee
   */
  modifier allow(address _owner, uint256 _required) {
    // The actor should be the permission owner or delegatee
    if (!opt.hasSufficientPermission(msg.sender, _owner, _required)) {
      revert AccessDenied(_owner, msg.sender, _required);
    }
    _;
  }

  /**
   * @dev Constructor
   */
  constructor(address _opt) {
    opt = IERC6366Core(_opt);
  }
}
