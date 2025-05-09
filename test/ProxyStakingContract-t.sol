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
    StakingContract_1 public stakeProxy;

    address user = address(0x3D311138b4439d5fba06b96F3aD30a8f944242C2);

    function setUp() public {
        token = new JamCoin(address(this));
        implementation = new StakingContract_1();

        proxy = new ProxyStakingContract(address(implementation));

        StakingContract_1(address(proxy)).initialize(address(token));

        token.updateContract(address(proxy));
        stakeProxy = StakingContract_1(address(proxy));
    }

    function testUnstake() public {
        uint value = 10 ether;

        vm.deal(user, 20 ether);

        vm.startPrank(user);
        stakeProxy.stake{value: value}(value);
        assertEq(address(proxy).balance, value);
        console.log("balance:", address(proxy).balance);
        stakeProxy.unstake(5 ether);
        console.log("user balance:", user.balance); // gets me 15 , test is reverting for some reason , will try in remix
        vm.stopPrank();

        assertEq(stakeProxy.totalStake(), 5 ether);
        assertEq(user.balance, 15 ether);
    }

    function testFailStake() public {
        uint value = 10 ether;
        stakeProxy.stake{value : value}(value);
        stakeProxy.unstake(value);
    }

    function testGetRewards() public {
        vm.deal(user, 10 ether);
        vm.prank(user);

        stakeProxy.stake{value: 2 ether}(2 ether);

        skip(86400);

        vm.prank(user);
        stakeProxy.claimRewards();

        uint balance = token.balanceOf(user);
        assertEq(balance, 2 * 86400 * 1e15);
    }
}