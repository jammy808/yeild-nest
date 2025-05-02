// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "forge-std/Script.sol";
import "../src/JamCoin.sol";
import "../src/ProxyStakingContract.sol";
import "../src/StakingContract_1.sol";

contract DeployStaking is Script {
    function run() external {
        // Grab deployer's private key
        uint256 deployerKey = vm.envUint("PRIVATE_KEY");

        vm.startBroadcast(deployerKey);

        // 1. Deploy staking logic contract
        StakingContract_1 stakingImpl = new StakingContract_1();

        // 2. Deploy proxy with stakingImpl as implementation
        ProxyStakingContract proxy = new ProxyStakingContract(address(stakingImpl));

        // 3. Deploy the token, passing proxy address as staking contract
        JamCoin token = new JamCoin(address(proxy));

        // 4. Initialize the proxy to call initialize()
        // This is a low-level call to initialize the proxy storage
        StakingContract_1(address(proxy)).initialize(address(token));

        vm.stopBroadcast();
    }
}