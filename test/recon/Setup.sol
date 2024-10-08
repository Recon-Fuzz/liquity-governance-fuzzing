
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseSetup} from "@chimera/BaseSetup.sol";

import {IInitiative} from "governance/interfaces/IInitiative.sol";

abstract contract Setup is BaseSetup {

    IInitiative initiative;
    address actor = address(this);
    address dummyBold = address(0x123);
    address dummyBribe = address(0x456);

    uint256 constant MIN_GAS_TO_HOOK = 350_000;

    function setup() internal virtual override {
        // TODO: replace dummy address passed in here with actual initiative address
        initiative = IInitiative(address(0x789)); 
    }
}
