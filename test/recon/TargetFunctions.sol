// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {vm} from "@chimera/Hevm.sol";
import {IInitiative} from "governance/interfaces/IInitiative.sol";
import {IGovernance} from "governance/interfaces/IGovernance.sol";

import {BeforeAfter} from "./BeforeAfter.sol";
import {Properties} from "./Properties.sol";
import {safeCallWithMinGas} from "governance/utils/SafeCallMinGas.sol";

abstract contract TargetFunctions is BaseTargetFunctions, Properties, BeforeAfter {
    bool prankingGovernance = true;

    function togglePrankGovernance() public {
        prankingGovernance = !prankingGovernance;
    }

    // Test doesn't revert
    function initiative_onRegisterInitiative(uint16 epoch) public {
        if (prankingGovernance) {
            vm.prank(MAINNET_GOVERNANCE);
        }

        bool callWithMinGas = safeCallWithMinGas(
            address(initiative), MIN_GAS_TO_HOOK, 0, abi.encodeCall(IInitiative.onRegisterInitiative, (epoch))
        );

        // calls made by governance should never fail, calls not made by governance should always fail
        if (prankingGovernance) {
            t(callWithMinGas, "call to onRegisterInitiative reverts with minimum gas");
        } else {
            t(!callWithMinGas, "Unathenticated call MUST fail");
        }
    }

    function intiative_onUnregisterInitiative(uint16 epoch) public {
        if (prankingGovernance) {
            vm.prank(MAINNET_GOVERNANCE);
        }

        bool callWithMinGas = safeCallWithMinGas(
            address(initiative), MIN_GAS_TO_HOOK, 0, abi.encodeCall(IInitiative.onUnregisterInitiative, (epoch))
        );

        if (prankingGovernance) {
            t(callWithMinGas, "call to onUnregisterInitiative reverts with minimum gas");
        } else {
            t(!callWithMinGas, "Unathenticated call MUST fail");
        }
    }

    function initiative_onAfterAllocateLQTY(
        uint16 currentEpoch,
        address user,
        IGovernance.UserState memory userState,
        IGovernance.Allocation memory allocation,
        IGovernance.InitiativeState memory initiativeState
    ) public {
        if (prankingGovernance) {
            vm.prank(MAINNET_GOVERNANCE);
        }

        bool callWithMinGas = safeCallWithMinGas(
            address(initiative),
            MIN_GAS_TO_HOOK,
            0,
            abi.encodeCall(
                IInitiative.onAfterAllocateLQTY, (currentEpoch, user, userState, allocation, initiativeState)
            )
        );

        if (prankingGovernance) {
            t(callWithMinGas, "call to onAfterAllocateLQTY reverts with minimum gas");
        } else {
            t(!callWithMinGas, "Unathenticated call MUST fail");
        }
    }

    function initiative_onClaimForInitiative(uint16 claimEpoch, uint256 bold) public {
        if (prankingGovernance) {
            vm.prank(MAINNET_GOVERNANCE);
        }

        bool callWithMinGas = safeCallWithMinGas(
            address(initiative),
            MIN_GAS_TO_HOOK,
            0,
            abi.encodeCall(IInitiative.onClaimForInitiative, (claimEpoch, bold))
        );

        if (prankingGovernance) {
            t(callWithMinGas, "call to onClaimForInitiative reverts with minimum gas");
        } else {
            t(!callWithMinGas, "Unathenticated call MUST fail");
        }
    }

    // Extra checks
    // If the Initiative is a BribesInitiative, then it must comply with the params from the Interface and Spec
    // Has those functions
    // Behaves in the same way (We could do differential fuzz tests against known impl)
    // This ensures the behaviour is the same
    // We just gotta grab the `governance` from both
}
