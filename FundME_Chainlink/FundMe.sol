// SPDX-License-Identifier:MIT
pragma solidity ^0.8.2;

import {AggregatorV3Interface} from "@chainlink/contracts/src/v0.8/shared/interfaces/AggregatorV3Interface.sol";
import "hardhat/console.sol";
contract FundMe{

    uint256 public minimumUSD=5e18;
    function fund() public payable {    
       require(getConversionRate(msg.value) >= minimumUSD,"Didn't send enough ETH");

    }

    function getPrice() public view returns(uint256){
        // Address 0x2514895c72f50D8bd4B4F9b1110F0D6bD2c97526
        AggregatorV3Interface priceFeed=AggregatorV3Interface(0x2514895c72f50D8bd4B4F9b1110F0D6bD2c97526);
        (, int256 answer,, ,) = priceFeed.latestRoundData();
        // console.log("Price ETH", answer);
        return uint256(answer*1e10);
     }

    function getConversionRate(uint256 ethAmount) public view returns(uint256){
        uint256 ethPrice=getPrice();
        uint256 ethAmontInUSD=(ethPrice*ethAmount)/1 ether;
        console.log("Price Amount ETH in USD",ethAmontInUSD);
        return ethAmontInUSD;
    }
    function getVersion() public view returns(uint256){
        return AggregatorV3Interface(0x2514895c72f50D8bd4B4F9b1110F0D6bD2c97526).version();
    }
}


// 0x526A76cbe536983146036eab04e6781CF60bA1b0