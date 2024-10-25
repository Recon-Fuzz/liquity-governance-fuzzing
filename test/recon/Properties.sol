
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Asserts} from "@chimera/Asserts.sol";
import {Setup} from "./Setup.sol";

abstract contract Properties is Setup, Asserts {
  function check_is_using_bold() public {
    address(initiative.bold()) == MAINNET_BOLD;
  }

  function check_governance() public {
    initiative.governance() == MAINNET_GOVERNANCE;
  }
}
