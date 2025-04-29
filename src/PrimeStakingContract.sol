// SPDX-License-Identifier: Unlicense
pragma solidity  ^0.8.0;

contract PrimeStakingContract {

    address public implementation;

    constructor ( ) {

    }

    fallback() external payable {
        (bool success , bytes memory data) = implementation.delegatecall(msg.data);
        require(success , "Delegate Call Failed");
    }
}