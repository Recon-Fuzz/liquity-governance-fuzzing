// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {TargetFunctions} from "./TargetFunctions.sol";
import {CryticAsserts} from "@chimera/CryticAsserts.sol";

// 	ECHIDNA_RPC_URL="your mainnet rpc url" ECHIDNA_RPC_BLOCK="block to fork from" echidna . --contract CryticForkTester --config echidna.yaml
contract CryticForkTester is TargetFunctions, CryticAsserts {
    constructor() payable {
        setupFork();
    }
}
