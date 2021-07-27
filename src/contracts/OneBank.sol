// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "./Rupee.sol";

contract OneBank {
    //assign Token contract to variable
    Rupee private rupee;

    //add mappings
    mapping(address => uint256) depositStart;
    mapping(address => bool) ehterBalenceOf;
    mapping(address => bool) isDeposited;

    //add events
    event Deposit(address indexed user, uint256 etherAmount, uint256 timeStart);

    //pass as constructor argument deployed Token contract
    constructor(Rupee _rupee) public {
        //assign token deployed contract to variable
        rupee = _rupee;
    }

    function deposit() public payable {
        //check if msg.sender didn't already deposited funds
        require(
            isDeposited[msg.sender] == false,
            "Sender has already deposited funds"
        );
        //check if msg.value is >= than 0.01 ETH
        require(
            msg.value > 1e16,
            "Deposit amount needs to be more than 0.01 ETH"
        );
        //increase msg.sender ether deposit balance
        ehterBalenceOf[msg.sender] = ehterBalenceOf[msg.sender] + msg.value;
        //start msg.sender hodling time
        depositStart[msg.sender] = depositStart[msg.sender] + block.timestamp;
        //set msg.sender deposit status to true
        isDeposited[msg.sender] = true;
        //emit Deposit event
        emit Deposit(msg.sender, msg.value, block.timestamp);
    }

    function withdraw() public {
        //check if msg.sender deposit status is true
        require(isDeposited[msg.sender] == true, "Error, no previous deposit");

        //assign msg.sender ether deposit balance to variable for event
        uint256 userBalance = ehterBalenceOf[msg.sender];

        //check user's hodl time
        uint256 depositTime = block.timestamp - depositStart[msg.sender];

        intrestPerSecond = 31668017 * (ehterBalenceOf[msg.sender]/1e16);
        uint intrest = interestPerSecond * depositTime;
        //send eth to user
        msg.sender.transfer(ehterBalenceOf[msg.sender]);
        //send interest in tokens to user
        token.mint(msg.sender,intrest);
        //reset depositer data
        depositStart[msg.sender] = 0;
        ehterBalenceOf[msg.sender] = 0;
        isDeposited[msg.sender] = false;

        //emit event
        emit Withdraw(msg.sender,userBalance,depositTime,intrest);

    uint interestPerSecond = 31668017 * (etherBalanceOf[msg.sender] / 1e16);
    uint interest = interestPerSecond * depositTime;
    msg.sender.transfer(etherBalanceOf[msg.sender]); //eth back to user
    token.mint(msg.sender, interest); //interest to user
    depositStart[msg.sender] = 0;
    etherBalanceOf[msg.sender] = 0;
    isDeposited[msg.sender] = false;
    emit Withdraw(msg.sender, userBalance, depositTime, interest);
    }

    function borrow() public payable {
        //check if collateral is >= than 0.01 ETH
        //check if user doesn't have active loan
        //add msg.value to ether collateral
        //calc tokens amount to mint, 50% of msg.value
        //mint&send tokens to user
        //activate borrower's loan status
        //emit event
    }

    function payOff() public {
        //check if loan is active
        //transfer tokens from user back to the contract
        //calc fee
        //send user's collateral minus fee
        //reset borrower's data
        //emit event
    }
}
