// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract FallbackExample {
    string public score;

    // A contract can have at most one receive function
    // this function is declared without the function keyword: receive() external payable {}
    // it cannot have arguments, cannot return anything and must have external visibility and payable state mutability.
    // it can be virtual, can override and can have modifiers.

    // receive function is executed on a call to the contract with empty calldata

    receive() external payable {
        score = "Receive function called";
    }

    // A contract can have at most one fallback function
    // it is also declared without the function keyword: fallback() external [payable] {} --- I think payable is optional
    // it can be virtual, can override and can have modifiers.

    // marked payable for it to receive ether
    fallback() external payable {
        score = "Fallback function called";
    }

    // The receive function is executed on a call to the contract with empty calldata.
    // This is the function that is executed on plain Ether transfers (e.g. via .send() or .transfer()).
    // If no such function exists, but a payable fallback function exists, the fallback function will be called on a plain Ether transfer.
    // If neither a receive Ether nor a payable fallback function is present, the contract cannot receive Ether through regular transactions and throws an exception.

    // The fallback function is executed on a call to the contract if none of the other functions match the given function signature,
    // or if no data was supplied at all and there is no receive Ether function.
    // The fallback function always receives data, but in order to also receive Ether it must be marked payable.
}