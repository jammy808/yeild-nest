// SPDX-License-Identifier: MIT
pragma solidity ^0.8.13;
import "@openzeppelin/contracts/token/ERC20/ERC20.sol";

contract JamCoin is ERC20 {

    address public stakingContract;

    constructor(address _stakingContract) ERC20 ("JamCoin" , "JAM") {
        stakingContract = _stakingContract;
    }

    modifier onlyContract() {
        require(msg.sender == stakingContract);
        _;
    }

    function mint(address to , uint256 amount) public onlyContract {
        _mint(to , amount);
    }

    function updateContract(address newContract) public onlyContract{
        stakingContract = newContract;
    }
}