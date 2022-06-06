// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

// remix is smart enough to know that we're importing a npm package
import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol"; // this will return an interface of a contract

// libraries are like contracts but you can't define state variable and can't send ether

library PriceConverter {
    // functions in library are going to be internal
    function getPrice() internal view returns (uint256) {
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

    function getConvertionRate(uint256 ethAmount) internal view returns (uint256) {
        uint256 ethPrice = getPrice();

        // in solidity, always try to multiply first before dividing
        uint256 ethAmountInUsd = (ethPrice * ethAmount) / 1e18;

        return ethAmountInUsd;
    }
}