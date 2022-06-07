// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

import "./PriceConverter.sol";

contract FundMe {
    using PriceConverter for uint256;

    uint256 public minimumUSD = 50 * 1e18; // this will be in wei
    address[] public funders;
    mapping(address => uint256) public addressToAmountFunded;

    // any function mark payable is used to send eth
    function fund() public payable {
        // msg is the person that calls this function
        // msg.value is the amount of eth the person is calling
        // require is a checker that makes sure a condition is true.
        // the function is reverted when require is not true. It reverts any action
        // that has been done and send the remaining gas back
        // require(msg.value > 1e18, "Didn't send enough eth"); // 1e18 = 1 * 10 ** 18wei = 1eth

        // require(getConvertionRate(msg.value) > minimumUSD, "Didn't send enough eth"); // 1e18 = 1 * 10 ** 18wei = 1eth
        // we're not passing any value into getConvertionRate because the the varaible that calls it is passed in as the first parameter
        require(msg.value.getConvertionRate() > minimumUSD, "Didn't send enough eth");

        funders.push(msg.sender); // msg.sender is the address of the person that calls this function
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function withdrawal() public {
        // for loop syntax -- for(startIndex, endIndex, step)
        for(uint256 index = 0; index < funders.length; index++) {
            address funder = funders[index];
            addressToAmountFunded[funder] = 0;
        }

        // to reset an array --- new arrayType[](length)
        // e.g new uint256[](0) --- an empty array of type uint256
        // e.g new string[](1) -- an array of string with one element

        // reset funders
        funders = new address[](0);

        // methods to send/withdraw ether from a contract
        // transfer -- maximum gas of 2300. It throws an error if failed, thereby automatically revert if it fails
        // send -- maximum gas of 2300. It returns true/false. You need to manually revert if it fails
        // call -- forward all gas or set gas. returns (true/false, function). Need to manually revert if it fails

        // address needs to be payable address when sending/receiving ether
        // address test = 0x8.........  type of address
        // payable(test) = .......... type of payable address

        // using transfer
        // payable(msg.sender).transfer(address(this).balance); // this revert if failed
        // msg.sender --- the address that calls this function
        // payable(msg.sender) --- typecast to payable address
        // this --- refers to current contract
        // address(this) -- typecast to address
        // address(this).balance -- ether available in this contract

        // using send
        // bool sendSuccess = payable(msg.sender).send(address(this).balance);
        // require(sendSuccess, "Withdraw failed"); // manually revert

        // using call command
        // pass in a callback function when using call. (Don't worry about this now, come back to it later)

        (bool sendSuccess, ) = payable(msg.sender).call{value: address(this).balance}(""); // leave it blank so as to use it as a transaction by using ("")
        require(sendSuccess, "Sending failed");
    }
}