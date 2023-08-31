//SPDX-License-Identifier: MIT

pragma solidity ^0.8.18;

import {PriceConverter} from "./PriceConverter.sol";

contract FundMe {
    //attach PriceConverter functions to uint256s
    using PriceConverter for uint256;

    //USD price needs to be $1e18
    uint256 public minimumUsd = 5e18;

    address[] public funders;
    mapping(address funder => uint256 amountFunded)
        public addressToAmountFunded;

    //syntactic sugar way of writting mappings
    //mapping (address => uint256) public addressToAmountFunded; for short!

    function fund() public payable {
        require(
            msg.value.getConversionRate() >= minimumUsd,
            "didn't send enough ETH"
        );
        funders.push(msg.sender);
        addressToAmountFunded[msg.sender] += msg.value;
    }

    function withdraw() public {
        for (
            uint256 funderIndex = 0;
            funderIndex < funders.length;
            funderIndex++
        ) {
            address funder = funders[funderIndex];
            addressToAmountFunded[funder] = 0;
        }
        //Reset the funders array after withdrawing everything
        funders = new address[](0);
    }
}
