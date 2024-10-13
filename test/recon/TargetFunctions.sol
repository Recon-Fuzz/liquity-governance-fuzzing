
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseTargetFunctions} from "@chimera/BaseTargetFunctions.sol";
import {vm} from "@chimera/Hevm.sol";
import {IERC20Permit} from "openzeppelin-contracts/contracts/token/ERC20/extensions/IERC20Permit.sol";
import {ILQTYStaking} from "governance/interfaces/ILQTYStaking.sol";
import {IUserProxy} from "governance/interfaces/IUserProxy.sol";
import {PermitParams} from "governance/utils/Types.sol";

import {console2} from "forge-std/Test.sol";
import {BeforeAfter} from "./BeforeAfter.sol";
import {Properties} from "./Properties.sol";



abstract contract TargetFunctions is BaseTargetFunctions, Properties, BeforeAfter {

    // clamps to a single initiative to ensure coverage in case both haven't been registered yet
    function governance_allocateLQTY_clamped_single_initiative(uint8 initiativesIndex, uint96 deltaLQTYVotes, uint96 deltaLQTYVetos) public {
        // clamp using the user's staked balance
        uint96 stakedAmount = IUserProxy(governance.deriveUserProxyAddress(user)).staked();
        
        address[] memory initiatives = new address[](1);
        initiatives[0] = _getDeployedInitiative(initiativesIndex);
        int176[] memory deltaLQTYVotesArray = new int176[](1);
        deltaLQTYVotesArray[0] = int176(uint176(deltaLQTYVotes % stakedAmount));
        int176[] memory deltaLQTYVetosArray = new int176[](1);
        deltaLQTYVetosArray[0] = int176(uint176(deltaLQTYVetos % stakedAmount));
        
        governance.allocateLQTY(initiatives, deltaLQTYVotesArray, deltaLQTYVetosArray);
    }

    // NOTE: this can be clamped to allocate to multiple initiatives at once
    function governance_allocateLQTY(address[] calldata initiatives, int176[] calldata deltaLQTYVotes, int176[] calldata deltaLQTYVetos) public {
        governance.allocateLQTY(initiatives, deltaLQTYVotes, deltaLQTYVetos);
    }

    function governance_claimForInitiative(address _initiative) public {
        governance.claimForInitiative(_initiative);
    }

    function governance_claimFromStakingV1(address _rewardRecipient) public {
        governance.claimFromStakingV1(_rewardRecipient);
    }

    function governance_deployUserProxy() public {
        governance.deployUserProxy();
    }

    function governance_depositLQTY(uint88 _lqtyAmount) public {
        governance.depositLQTY(_lqtyAmount);
    }

    function governance_depositLQTYViaPermit(uint88 _lqtyAmount) public {
         // Get the current block timestamp for the deadline
        uint256 deadline = block.timestamp + 1 hours;

        // Create the permit message
        bytes32 permitTypeHash = keccak256("Permit(address owner,address spender,uint256 value,uint256 nonce,uint256 deadline)");
        bytes32 domainSeparator = IERC20Permit(address(lqty)).DOMAIN_SEPARATOR();
        
        uint256 nonce = IERC20Permit(address(lqty)).nonces(user);
        
        bytes32 structHash = keccak256(abi.encode(
            permitTypeHash,
            user,
            address(governance),
            _lqtyAmount,
            nonce,
            deadline
        ));

        bytes32 digest = keccak256(abi.encodePacked(
            "\x19\x01",
            domainSeparator,
            structHash
        ));

        (uint8 v, bytes32 r, bytes32 s) = vm.sign(user2Pk, digest);

        PermitParams memory permitParams = PermitParams({
            owner: user2,
            spender: user,
            value: _lqtyAmount,
            deadline: deadline,
            v: v,
            r: r,
            s: s
        });

        governance.depositLQTYViaPermit(_lqtyAmount, permitParams);
    }

    function governance_registerInitiative(uint8 initiativeIndex) public {
        address initiative = _getDeployedInitiative(initiativeIndex);
        governance.registerInitiative(initiative);
    }

    function governance_snapshotVotesForInitiative(address _initiative) public {
        governance.snapshotVotesForInitiative(_initiative);
    }

    function governance_unregisterInitiative(uint8 initiativeIndex) public {
        address initiative = _getDeployedInitiative(initiativeIndex);
        governance.unregisterInitiative(initiative);
    }

    function governance_withdrawLQTY(uint88 _lqtyAmount) public {
        governance.withdrawLQTY(_lqtyAmount);
    }
}
