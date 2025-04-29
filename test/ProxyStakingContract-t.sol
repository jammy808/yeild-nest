// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/JamCoin.sol";
import "src/ProxyStakingContract.sol";
import "src/StakingContract_1.sol";

contract ProxyStakingContractTest is Test {
    ProxyStakingContract public proxy;
    StakingContract_1 public implementation;
    JamCoin public token;

    address user = address(1);

    function setUp() public {
        token = new JamCoin(address(this));
        implementation = new StakingContract_1();

        proxy = new ProxyStakingContract(address(implementation));

        StakingContract_1(address(proxy)).initialize(address(token));

        token.updateContract(address(proxy));
    }
}