// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {FoundryAsserts} from "@chimera/FoundryAsserts.sol";
import {Test} from "forge-std/Test.sol";
import {console} from "forge-std/console.sol";

import {TargetFunctions} from "./TargetFunctions.sol";

contract CryticToFoundry is Test, TargetFunctions, FoundryAsserts {
    function setUp() public {
        setup();
    }

    function test_basic() public {
        console.log("test works");
    }

    // reverts because Initiative contract is still not finalized so all functions revert by default
    function test_registering() public {
        initiative_onRegisterInitiative(3);
    }
}
