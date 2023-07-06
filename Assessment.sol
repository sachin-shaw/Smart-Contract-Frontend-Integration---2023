// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract Assessment {
    address payable public owner;
    uint256 public balance;

    event Deposit(uint256 amount);
    event Withdraw(uint256 amount);
    event Transfer(address indexed recipient, uint256 amount);

    constructor(uint initBalance) payable {
        owner = payable(msg.sender);
        balance = initBalance;
    }

    function getBalance() public view returns (uint256) {
        return balance;
    }

    function deposit(uint256 _amount) public payable {
        require(msg.sender == owner, "You are not the owner of this account");
        uint256 _previousBalance = balance;
        balance += _amount;
        assert(balance == _previousBalance + _amount);
        emit Deposit(_amount);
    }

    error InsufficientBalance(uint256 balance, uint256 withdrawAmount);

    function withdraw(uint256 _withdrawAmount) public {
        require(msg.sender == owner, "You are not the owner of this account");
        uint256 _previousBalance = balance;
        if (balance < _withdrawAmount) {
            revert InsufficientBalance(balance, _withdrawAmount);
        }
        balance -= _withdrawAmount;
        assert(balance == _previousBalance - _withdrawAmount);
        emit Withdraw(_withdrawAmount);
    }

    error InsufficientBalance2(uint256 balance, uint256 _transferAmount);

    function transfer(address payable recipient, uint256 _transferAmount) public {
        require(msg.sender == owner, "You are not the owner of this account");
        uint256 _previousBalance = balance;
        if (balance < _transferAmount) {
            revert InsufficientBalance2(balance, _transferAmount);
        }

        balance -= _transferAmount;
        assert(balance == _previousBalance - _transferAmount);
        
        emit Transfer(recipient, _transferAmount);
    }

    function increaseBalance(uint256 _amount) public payable {
    require(msg.sender == owner, "You are not the owner of this account");
    balance += _amount;
    }

    function decreaseBalance(uint256 _amount) public {
    require(msg.sender == owner, "You are not the owner of this account");
    require(balance >= _amount, "Insufficient balance");

    balance -= _amount;
   }

   function getOwner() public view returns(address) {
    return owner;
   }

   function transferOwnership(address payable newOwner) public {
    require(msg.sender == owner, "You are not the owner of this account");
    owner = newOwner;
   }

}
