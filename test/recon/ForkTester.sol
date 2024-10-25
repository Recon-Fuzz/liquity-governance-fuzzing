// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {TargetFunctions} from "./TargetFunctions.sol";
import {CryticAsserts} from "@chimera/CryticAsserts.sol";

// echidna . --contract ForkTester --config echidna.yaml
// medusa fuzz
contract ForkTester is TargetFunctions, CryticAsserts {
    constructor() payable {
        setupFork();
    }
}
