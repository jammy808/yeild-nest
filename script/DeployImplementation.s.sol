// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/StakingContract_1.sol";

contract DeployImplementation is Script {
    function run() external {

        uint256 deployerKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerKey);

        StakingContract_1 stakingImpl = new StakingContract_1();

        vm.stopBroadcast();

    }
}