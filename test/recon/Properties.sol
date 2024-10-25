// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {Asserts} from "@chimera/Asserts.sol";
import {Setup} from "./Setup.sol";

// check that forked setup is properly configured
abstract contract Properties is Setup, Asserts {
    function check_is_using_bold() public {
        t(address(initiative.bold()) == MAINNET_BOLD, "Must use correct BOLD");
    }

    function check_governance() public {
        t(address(initiative.governance()) == MAINNET_GOVERNANCE, "Must use correct GOVERNANCE");
    }
}
