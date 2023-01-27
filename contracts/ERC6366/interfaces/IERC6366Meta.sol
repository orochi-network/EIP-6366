// SPDX-License-Identifier: MIT
pragma solidity ^0.8.7;

/**
 * @dev Defined the interface of the metadata of ERC6366, SHOULD NOT expect to be implemented
 */
interface IERC6366Meta {
  struct PermissionDescription {
    uint256 index;
    uint256 permission;
    string name;
    string description;
  }

  event UpdatePermissionDescription(uint256 indexed _permission, string indexed _name, string indexed _description);

  function name() external view returns (string memory);

  function symbol() external view returns (string memory);

  function getAllDescription() external view returns (PermissionDescription[] memory allDescription);

  function getDescription(uint256 _index) external view returns (PermissionDescription memory description);

  function setDescription(
    uint256 _index,
    string memory _name,
    string memory _description
  ) external returns (bool success);
}
