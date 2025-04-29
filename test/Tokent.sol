// SPDX-License-Identifier: Unlicense
pragma solidity ^0.8.13;

import "forge-std/Test.sol";

import "src/JamCoin.sol";

contract TokenContractTest is Test {
    JamCoin c;

    function setUp() public {
        c = new JamCoin(address(this));
    }

    function testMint() public {
        uint value = 10;
        c.mint(address(this) , value);

        assert(c.balanceOf(address(this)) == value);
    }

    function testFailMint() public {
        uint value = 10;
        vm.startPrank(0x587EFaEe4f308aB2795ca35A27Dff8c1dfAF9e3f);

        c.mint(address(this) , value);
    }
}