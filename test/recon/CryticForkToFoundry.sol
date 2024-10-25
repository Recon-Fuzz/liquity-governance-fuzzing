// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {FoundryAsserts} from "@chimera/FoundryAsserts.sol";
import {Test, console} from "forge-std/Test.sol";

import {TargetFunctions} from "./TargetFunctions.sol";

contract CryticForkToFoundry is Test, TargetFunctions, FoundryAsserts {
    function setUp() public {
        string memory MAINNET_RPC_URL = vm.envString("MAINNET_RPC_URL");
        uint256 FORK_FROM_BLOCK = vm.envUint("FORK_FROM_BLOCK");
        // TODO: when testing locally change this block with block from coverage report set inside setUpFork
        vm.createSelectFork(MAINNET_RPC_URL, FORK_FROM_BLOCK); 

        setupFork();
    }

    function test_basic_fork() public {
        console.log("setup works");
    }
}
