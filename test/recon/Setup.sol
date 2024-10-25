// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseSetup} from "@chimera/BaseSetup.sol";

import {IInitiative} from "governance/interfaces/IInitiative.sol";

import {Initiative} from "src/Initiative.sol";

abstract contract Setup is BaseSetup {
    Initiative initiative; // TODO IInitiative is not great, we should update it a bit

    // TODO: Update these values
    address constant MAINNET_GOVERNANCE = address(0);
    address constant MAINNET_BOLD = address(0);

    uint256 constant MIN_GAS_TO_HOOK = 350_000;

    function setup() internal virtual override {
        initiative = new Initiative(MAINNET_GOVERNANCE, MAINNET_BOLD);

        // Is this a BribeInitiative?
        // can be determined by checking for a few functions
        // NOTE: Liquity could create a Interface and use that via EIP-165
        // Alternatively, we would ask an AI to check this
        // But that's not exactly easy to do
    }
}
