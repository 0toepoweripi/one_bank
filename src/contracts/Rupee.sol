// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;


import "@openzeppelin/contracts/token/ERC20/ERC20.sol";


contract Rupee is ERC20 {
  //add minter variable
    address public minter;

  //add minter changed event
    event MinterChanged(address indexed from, address to);
    constructor() public payable ERC20("Rupee", "R") {
    //asign initial minter
    minter = msg.sender;
  }



  //Add pass minter role function
  function passMinterRole(address one_bank) public returns (bool) {
    require(msg.sender == minter, "Only Owner can change the minter role");
    minter = one_bank;
    emit MinterChanged(msg.sender,one_bank);
    return true;
  }

  function mint(address account, uint256 amount) public {
    //check if msg.sender have minter role
    require(msg.sender == minter,"Message sender does not have a minter role");
		_mint(account, amount);
	}
}