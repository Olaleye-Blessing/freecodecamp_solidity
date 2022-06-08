// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract A {
    address payable owner;
    uint age;
    bool valid;

    constructor(uint _age) {
        owner = payable(msg.sender);
        age = _age;
    }

    modifier onlyOwner {
        require(msg.sender == owner, "Sorry, invalid call");
        _;
    }

    // modifier can also receive arguments
    modifier adult(uint _age) {
        require(_age == age, "Underage!!!");
        _; // this executes the function body
    }
}

contract B is A(12) {
    function withdraw() public onlyOwner {
        (bool success, ) = owner.call{value: address(this).balance}("");
        require(success, "Withdraw failed");
    }

    function isAdult(uint _age) public adult(_age) {
        valid = true;
    }

    // Multiple modifiers are applied to a function by specifying them in a whitespace-separated list and are evaluated in the order presented.

    function adultWithdraw(uint _age) public adult(_age) onlyOwner {
        (bool success, ) = owner.call{value: address(this).balance}("");
        require(success, "Withdraw failed");
    }
}