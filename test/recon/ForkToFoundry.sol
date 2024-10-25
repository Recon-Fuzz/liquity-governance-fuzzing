// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {FoundryAsserts} from "@chimera/FoundryAsserts.sol";
import {Test} from "forge-std/Test.sol";

import {TargetFunctions} from "./TargetFunctions.sol";

contract ForkToFoundry is Test, TargetFunctions, FoundryAsserts {
    function setUp() public {
        setupFork();
    }
}