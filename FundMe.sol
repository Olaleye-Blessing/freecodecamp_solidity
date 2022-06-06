// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// remix is smart enough to know that we're importing a npm package
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; // this will return an interface of a contract

contract FundMe {
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

        require(getConvertionRate(msg.value) > minimumUSD, "Didn't send enough eth"); // 1e18 = 1 * 10 ** 18wei = 1eth

        funders.push(msg.sender); // msg.sender is the address of the person that calls this function
        addressToAmountFunded[msg.sender] = msg.value;
    }

    function getPrice() public view returns(uint256) {
        // 0x8A753747A1Fa494EC906cE90E9f37563A8AF630e -- address to test ETH/USD
        AggregatorV3Interface priceFeed = AggregatorV3Interface(0x8A753747A1Fa494EC906cE90E9f37563A8AF630e);

        // latestRoundData() returns multiple value
        // (uint80 roundId, int256 price, uint256 startedAt, uint256 updatedAt, uint80 answeredInRound) = priceFeed.latestRoundData()

        // replace the values you dont need from the multiple values returned by a function with comma
        (,int256 price,,,) = priceFeed.latestRoundData(); // price of ETH in USD
        // price will be whole_price.yyyyyyyy --- 8 decimal places. So this needs to be converted to 18 decials which means multiply by 10^10
        // the above is done to get msg.value to match up with price

        // price needs to be converted to uint256 cause msg.value is in uint256
        return uint256(price * 1e10);
    }

    function getConvertionRate(uint256 ethAmount) public view returns(uint256) {
        uint256 ethPrice = getPrice();

        // in solidity, always try to multiply first before dividing
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;

        return ethAmountInUsd;
    }
}