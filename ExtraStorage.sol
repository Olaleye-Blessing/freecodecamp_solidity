// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./SimpleStorage.sol";

// this contract inherits from SimpleStorage
contract ExtraStorage is SimpleStorage {
    // we have access to all functions and variables in SimpleStorage at this point

    // use `override` and `virtual` keywords when you want to override a function
    // add virtual to the parent function that you want to override
    // add override to the child function that you want to override
    function changeNumber(uint256 _number) public override {
        hiddenByDefault = _number + 100;
        newScore = _number + 400;
    }
}