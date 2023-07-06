# Smart-Contract-Frontend-Integration---2023

## The Assessment contract is a Solidity smart contract that allows the owner to manage a balance, deposit and withdraw funds, transfer funds to other addresses, and transfer ownership of the contract.

## Description

function getBalance(): This function is a view function that returns the current balance of the contract.

function deposit(uint256 _amount): This function allows the contract owner to deposit funds into the contract. The specified amount is added to the contract balance, and the "Deposit" event is emitted.

error InsufficientBalance(uint256 balance, uint256 withdrawAmount): This error is defined to handle cases where the contract owner tries to withdraw an amount greater than the contract's balance.

function withdraw(uint256 _withdrawAmount): This function allows the contract owner to withdraw funds from the contract. It checks if the contract has sufficient balance to fulfill the withdrawal request. If the balance is insufficient, it reverts the transaction with the "InsufficientBalance" error. Otherwise, the specified amount is subtracted from the contract balance, and the "Withdraw" event is emitted.

error InsufficientBalance2(uint256 balance, uint256 _transferAmount): This error is defined to handle cases where the contract owner tries to transfer an amount greater than the contract's balance.

function transfer(address payable recipient, uint256 _transferAmount): This function allows the contract owner to transfer funds from the contract to another address. It checks if the contract has sufficient balance to fulfill the transfer request. If the balance is insufficient, it reverts the transaction with the "InsufficientBalance2" error. Otherwise, the specified amount is subtracted from the contract balance, and the "Transfer" event is emitted with the recipient's address and the transfer amount.

function increaseBalance(uint256 _amount): This function allows the contract owner to increase the contract balance. The specified amount is added to the contract balance.

function decreaseBalance(uint256 _amount): This function allows the contract owner to decrease the contract balance. It checks if the contract has sufficient balance to fulfill the decrease request. If the balance is insufficient, it reverts the transaction with an "Insufficient balance" error. Otherwise, the specified amount is subtracted from the contract balance.

function getOwner(): This function is a view function that returns the address of the contract owner.

function transferOwnership(address payable newOwner): This function allows the current contract owner to transfer ownership to another address. This function is designed to change the owner of the contract and does not modify the contract balance. It ensures that only the current owner can transfer ownership, preventing unauthorized changes to the contract's administration.

## difference between deposit function and increaseBalance function
The deposit function and the increaseBalance function in the given smart contract have different purposes and behaviors:

deposit function: This function allows the contract owner to deposit funds into the contract. It is designed to increase the contract balance by a specified amount. The function takes a parameter _amount representing the amount to be deposited. The contract checks if the msg.sender (the caller of the function) is the contract owner. If the condition is satisfied, the _amount is added to the current balance using the += operator. Additionally, the function emits a Deposit event to indicate that a deposit has been made. This function is payable, meaning the caller must send Ether along with the function call.

increaseBalance function: This function also allows the contract owner to increase the contract balance, but it does not require the caller to send Ether. It takes a parameter _amount representing the amount by which the balance should be increased. Similar to the deposit function, it checks if the msg.sender is the contract owner. If the condition is satisfied, the _amount is added to the current balance using the += operator. However, this function does not emit any event. It can be used to programmatically increase the balance without requiring an external transaction or funds transfer.

In summary, the deposit function is used to deposit funds into the contract by the owner, whereas the increaseBalance function is used to programmatically increase the contract balance without involving external transactions or transfers.
## Getting Started
### Executing program
To run this program, you can use Remix, an online Solidity IDE. To get started, go to the Remix website at https://remix.ethereum.org/.

Once you are on the Remix website, create a new file by clicking on the "+" icon in the left-hand sidebar. Save the file with a .sol extension (e.g., errorHandling.sol). Copy and paste the following code into the file:

```javascript
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

```

To compile the code, click on the "Solidity Compiler" tab in the left-hand sidebar. Make sure the "Compiler" option is set to "0.8.9" (or another compatible version), and then click on the "Compile Assessment.sol" button.

Once the code is compiled, you can deploy the contract by clicking on the "Deploy & Run Transactions" tab in the left-hand sidebar. Select the "Assessment" contract from the dropdown menu, and then click on the "Deploy" button.

Once the contract is deployed, you can interact with it by calling the different function. 

## Frontend Integration
You need to setup following tools :
1. Hardhat : Hardhat is a popular development environment for building, testing, and deploying smart contracts on the Ethereum blockchain. It provides a comprehensive set of tools and features to facilitate the development process.
2. React : React is a popular JavaScript library for building user interfaces. It provides a declarative and component-based approach to building UIs, making it easier to manage complex UIs and update them efficiently.
3. Metamask : MetaMask is a popular browser extension and digital wallet that allows users to manage their Ethereum accounts and interact with decentralized applications (dApps) on the Ethereum blockchain.
4. Next : Next.js is a popular React framework for building server-side rendered (SSR) and statically generated (SSG) web applications. It provides several features and optimizations that enhance the development experience and performance of React applications.

## index.js
```javascript

// set up index.js in react

```

## deploy.js
```javascript

// set and update deploy.js in hardhat

```
## Update contracts in hardhat
```javascript

//  Move in contracts folder update Lock.sol with Assessment.sol in hardhat

```
## Update hardhat.config.js in hardhat
```javascript

// set and update hardhat.config.js in hardhat

```

# Starter Next/Hardhat Project

After cloning the github, you will want to do the following to get the code running on your computer.

1. Inside the project directory, in the terminal type: npm i
2. Open two additional terminals in your VS code
3. In the second terminal type: npx hardhat node
4. In the third terminal, type: npx hardhat run --network localhost scripts/deploy.js
5. Back in the first terminal, type npm run dev to launch the front-end.

After this, the project will be running on your localhost. 
Typically at http://localhost:3000/

## Authors
Sachin kumar

