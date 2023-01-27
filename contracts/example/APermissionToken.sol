// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;
import '../ERC6366/ERC6366Core.sol';
import '../ERC6366/ERC6366Meta.sol';

/**
 * @dev An example for mintable permission token
 */
contract APermissionToken is ERC6366Core, ERC6366Meta {
  /**
   * @dev Permission to transfer permission token
   */
  uint256 private constant PERMISSION_TRANSFER = 2 ** 2;

  /**
   * @dev Permission to manage permission token
   */
  uint256 private constant PERMISSION_MASTER = 2 ** 255;

  /**
   * @dev Checking for require permissioned from the actor
   */
  modifier allow(uint256 required) {
    address owner = msg.sender;
    if (!_permissionRequire(required, _permissionOf(owner))) {
      revert AccessDenied(owner, owner, required);
    }
    _;
  }

  /**
   * @dev Construct ERC-6366
   */
  constructor() ERC6366Meta('Ecosystem A Permission Token', 'APT') {
    _setDescription(0, 'PERMISSION_DENIED', 'Blacklisted address');
    _setDescription(1, 'PERMISSION_VOTE', 'Permission owner able to vote');
    _setDescription(2, 'PERMISSION_TRANSFER', 'Permission owner able to transfer');
    _setDescription(3, 'PERMISSION_EXECUTE', 'Permission owner able to execute');
    _setDescription(4, 'PERMISSION_CREATE', 'Permission owner able to create');
    _setDescription(255, 'PERMISSION_MASTER', 'Permission owner able to mint and update desscription');
    // Assign master permission to deployer
    _mint(msg.sender, PERMISSION_MASTER);
  }

  /**
   * @dev Mint a set of permission to a given target address
   */
  function mint(address _to, uint256 _permission) external allow(PERMISSION_MASTER) returns (bool result) {
    return _mint(_to, _permission);
  }

  /**
   * @dev Burn all permission of a given target address
   */
  function burn(address _to) external allow(PERMISSION_MASTER) returns (bool result) {
    return _burn(_to);
  }

  /**
   * @dev Set the description of given index
   * @param _index Description's index
   * @param _name Name of the permission
   * @param _description Description of the permission
   */
  function setDescription(
    uint256 _index,
    string memory _name,
    string memory _description
  ) external virtual override allow(PERMISSION_MASTER) returns (bool) {
    // This method is empty, you should override this in your implement
  }

  /**
   * @dev Transfer a subset of permission to a given target address
   */
  function transfer(
    address _to,
    uint256 _permission
  ) external override allow(PERMISSION_TRANSFER) returns (bool result) {
    return _transfer(_to, _permission);
  }
}
