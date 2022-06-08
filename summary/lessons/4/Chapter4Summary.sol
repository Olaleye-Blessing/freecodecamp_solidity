// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract More {
    // loops
    // always try to avaoid loop cause of the price that comes with it: GAS
    address[] public loopAddress;

    function forLoopTest() public view{
        for (uint i = 0; i < loopAddress.length; i++) {
            // do some work
        }
    }

    function whileLoopTest() public view {
        uint index = 0;
        while(index < loopAddress.length) {
            // do some work
            index++;
        }
    }

    // constructor
    // A constructor is an optional function declared with the constructor keyword which is executed upon contract creation, and where you can run contract initialisation code.

    // If there is no constructor, the contract will assume the default constructor, which is equivalent to constructor() {}.
    uint public value = 200;

    constructor() {
        value = 40;
    }
}