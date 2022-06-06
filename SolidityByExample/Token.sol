// SPDX-License-Identifier: GPL-3.0
pragma solidity >=0.5.0 <0.9.0;

import "./Balances.sol";

contract Token {
    // use this syntax in order to use a library
    // using LibraryName for type;

    // using Balances for uint256;
    // using Balances for *; use library for any data type


    using Balances for *;
    mapping(address => uint256) balances;
    mapping(address => mapping(address => uint256)) allowed;

    function transfer(address to, uint amount) external returns (bool success) {
        balances.move(msg.sender, to, amount); // rememeber the variable that calls a library function is passed in as the first parameter

        // we will get here if move function was successful.
        return true;
    }

    function transferFrom(address from, address to, uint amount) external returns (bool success) {
        require(allowed[from][msg.sender] >= amount);
        allowed[from][msg.sender] -= amount;
        balances.move(from, to, amount);
        return true;
    }

    function approve(address spender, uint tokens) external returns (bool success) {
        require(allowed[msg.sender][spender] == 0, "");
        allowed[msg.sender][spender] = tokens;
        return true;
    }
}