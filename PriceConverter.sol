//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

library PriceConverter {
    function getPrice() internal view returns (uint256) {
        //Address 0x694AA1769357215DE4FAC081bf1f309aDC325306
        //ABI
        AggregatorV3Interface priceFeed = AggregatorV3Interface(
            0x694AA1769357215DE4FAC081bf1f309aDC325306
        );
        (, int256 price, , , ) = priceFeed.latestRoundData(); //because it returns a set of variables
        //Price of ETH in terms of USD
        // 2000_00000000 = 2000 * 1e8 = 2000$ * 1e18
        return uint256(price * 1e10); //to make it 2000 * 1e18
    }

    function getConversionRate(
        uint256 ethAmount
    ) internal view returns (uint256) {
        //converts msg.value(ETH) to its converted price(USD)
        uint256 ethPrice = getPrice();
        uint256 ethAmountInUsd = (ethAmount * ethPrice) / 1e18; //1.e18 * 1.e18 = 1e32 -> we need 1e18
        return ethAmountInUsd;
    }
}
