// SPDX-License-Identifier: Unlicense
pragma solidity  ^0.8.13;

contract ProxyStakingContract {

    address public implementation;
    address public admin;

    constructor (address _implementation) {
        implementation = _implementation;
        admin = msg.sender;
    }

    function upgrade(address newImplementation) external {
        require(msg.sender == admin , "Only Admin");
        implementation = newImplementation;
    }

    fallback() external payable {
        require(implementation != address(0) , "No implementation set");

        (bool success , ) = implementation.delegatecall(msg.data);
        require(success , "Delegate Call Failed");
    }

    receive() external payable {}
}