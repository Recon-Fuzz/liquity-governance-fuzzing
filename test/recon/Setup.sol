
// SPDX-License-Identifier: GPL-2.0
pragma solidity ^0.8.0;

import {BaseSetup} from "@chimera/BaseSetup.sol";
import {console2} from "forge-std/Test.sol";
import {vm} from "@chimera/Hevm.sol";
import {IERC20} from "forge-std/interfaces/IERC20.sol";
import {Governance} from "governance/Governance.sol";
import {IGovernance} from "governance/interfaces/IGovernance.sol";
import {IInitiative} from "governance/interfaces/IInitiative.sol";

import {MockERC20Tester} from "../mocks/MockERC20Tester.sol";
import {MockStakingV1} from "../mocks/MockStakingV1.sol";
import {MaliciousInitiative} from "../mocks/MaliciousInitiative.sol";

abstract contract Setup is BaseSetup {
    Governance governance;
    MockERC20Tester internal lqty;
    MockERC20Tester internal lusd;
    IInitiative internal initiative1;
    IInitiative internal initiative2;

    address internal user = address(this);
    // derived using makeAddrAndKey
    address internal user2 = address(0x537C8f3d3E18dF5517a58B3fB9D9143697996802);
    uint256 internal user2Pk = 23868421370328131711506074113045611601786642648093516849953535378706721142721; 
    address internal stakingV1;
    address internal userProxy;
    address[] internal deployedInitiatives;

    uint128 internal constant REGISTRATION_FEE = 1e18;
    uint128 internal constant REGISTRATION_THRESHOLD_FACTOR = 0.01e18;
    uint128 internal constant UNREGISTRATION_THRESHOLD_FACTOR = 4e18;
    uint16 internal constant REGISTRATION_WARM_UP_PERIOD = 4;
    uint16 internal constant UNREGISTRATION_AFTER_EPOCHS = 4;
    uint128 internal constant VOTING_THRESHOLD_FACTOR = 0.04e18;
    uint88 internal constant MIN_CLAIM = 500e18;
    uint88 internal constant MIN_ACCRUAL = 1000e18;
    uint32 internal constant EPOCH_DURATION = 604800;
    uint32 internal constant EPOCH_VOTING_CUTOFF = 518400;

    // TODO:
    // 1. mint liquity to user x
    // 2. mock staking tokens x
    // 3. deploy Governance x
    // 4. deploy Proposal x
    // 5. set proposal on governance x
  function setup() internal virtual override {
      uint256 initialMintAmount = type(uint88).max;
      lqty = new MockERC20Tester(user, initialMintAmount, "Liquity", "LQTY", 18);
      lusd = new MockERC20Tester(user, initialMintAmount, "Liquity USD", "LUSD", 18);
      lqty.mint(user2, initialMintAmount);

      stakingV1 = address(new MockStakingV1(address(lqty)));
      governance = new Governance(
          address(lqty), 
          address(lusd),
          stakingV1,
          address(lusd), // bold
          IGovernance.Configuration({
              registrationFee: REGISTRATION_FEE,
              registrationThresholdFactor: REGISTRATION_THRESHOLD_FACTOR,
              unregistrationThresholdFactor: UNREGISTRATION_THRESHOLD_FACTOR,
              registrationWarmUpPeriod: REGISTRATION_WARM_UP_PERIOD,
              unregistrationAfterEpochs: UNREGISTRATION_AFTER_EPOCHS,
              votingThresholdFactor: VOTING_THRESHOLD_FACTOR,
              minClaim: MIN_CLAIM,
              minAccrual: MIN_ACCRUAL,
              epochStart: uint32(block.timestamp),
              epochDuration: EPOCH_DURATION,
              epochVotingCutoff: EPOCH_VOTING_CUTOFF
          }),
          deployedInitiatives // no initial initiatives passed in because don't have cheatcodes for calculating address where gov will be deployed
      );

      // deploy proxy so user can approve it
      userProxy = governance.deployUserProxy();
      lqty.approve(address(userProxy), initialMintAmount);
      lusd.approve(address(userProxy), initialMintAmount);

      // approve governance for user's tokens
      lqty.approve(address(governance), initialMintAmount);
      lusd.approve(address(governance), initialMintAmount);

      // register one of the initiatives, leave the other for registering/unregistering via TargetFunction
      initiative1 = IInitiative(address(new MaliciousInitiative()));
      initiative2 = IInitiative(address(new MaliciousInitiative()));
      deployedInitiatives.push(address(initiative1));
      deployedInitiatives.push(address(initiative2));

      governance.registerInitiative(address(initiative1));
  }

  function _getDeployedInitiative(uint8 index) public returns (address initiative) {
    return deployedInitiatives[index % deployedInitiatives.length];
  }

  function _getClampedTokenBalance(address token, address holder) public returns (uint256 balance) {
    return IERC20(token).balanceOf(holder);
  }
  
}
