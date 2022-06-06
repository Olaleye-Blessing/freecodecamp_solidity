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
}