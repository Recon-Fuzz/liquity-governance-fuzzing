
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseSetup} from "@chimera/BaseSetup.sol";

import {IERC20} from "openzeppelin-contracts/contracts/interfaces/IERC20.sol";
import {SafeERC20} from "openzeppelin-contracts/contracts/token/ERC20/utils/SafeERC20.sol";

import {IInitiative} from "governance/interfaces/IInitiative.sol";
import {IGovernance} from "governance/interfaces/IGovernance.sol";

/// @dev Initiative scaffold contract
/// Each hook must:
/// Validate that the caller is governance
///
contract Initiative is IInitiative {
  using SafeERC20 for IERC20;

  address public immutable governance;
  IERC20 public immutable bold;

    constructor(address _governance, address _bold) {
      governance = _governance;
      bold = IERC20(_bold);
    }

    modifier onlyGovernance() {
      require(msg.sender == address(governance), "BribeInitiative: invalid-sender");
      _;
    }

    function onRegisterInitiative(uint16 _atEpoch) external override onlyGovernance {
      revert("TODO onRegisterInitiative");
    }

    function onUnregisterInitiative(uint16 _atEpoch) external override onlyGovernance {
      revert("TODO onUnregisterInitiative");
    }


    function onAfterAllocateLQTY(uint16 _currentEpoch, address _user, IGovernance.UserState calldata userState, IGovernance.Allocation calldata allocation, IGovernance.InitiativeState calldata initiativeState) external override onlyGovernance {
      revert("TODO onAfterAllocateLQTY");
    }

    function onClaimForInitiative(uint16 _claimEpoch, uint256 _bold) external override onlyGovernance {
      revert("TODO onClaimForInitiative");
    }
}