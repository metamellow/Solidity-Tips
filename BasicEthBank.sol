    // SPDX-License-Identifier: MIT
    pragma solidity ^0.8.9;

    /* ================ BASIC ETH BANK ================
    [1] Create a place to store bank users balances
    [2] Function that updates users balance to msg.value
    --- 'payable' means it can receive the 'value' (ETH)
    [3] Function that starts to withdraw the '_amount'
    --- a. record the current 'userBalance'
    --- b. check userBalance is greater than '_amount'
    --- c. update bankBalance to show remaining balance
    --- d. send user _amount & show 'success' if finished
    ================================================= */

    contract BasicEthBank{
        //[1]
        mapping(address => uint) public bankBalances;

        //[2]
        function depositETH() external payable{
            bankBalances[msg.sender] += msg.value;
        }
        
        //[3]
        function withdrawETH(uint _amount) public{
            uint userBalance = bankBalances[msg.sender];
            require(userBalance >= _amount, "Error1 - Withdraw canceled");
            bankBalances[msg.sender] = userBalance - _amount;
            (bool success, ) = msg.sender.call{value: _amount}("");
            require(success, "Error2 - Withdraw canceled");
        }
    }