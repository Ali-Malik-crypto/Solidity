// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./AuroBullet.sol";

contract PresaleToken {
    address admin;
    AuroBullet public tokenContract;
    uint256 public tokenPrice;
    uint256 public tokenSold; 

    event Sell(address _buyer,uint256 _amount);

    constructor(AuroBullet _tokenContract, uint256 _tokenPrice){
        admin = msg.sender;
        tokenContract = _tokenContract;
        tokenPrice = _tokenPrice;   
    }

    function buyTokens(uint256 _numberOfToken) public payable {
        require(msg.value >=  tokenPrice * _numberOfToken);
        require(tokenContract.balanceOf(address(this)) >= _numberOfToken);
       
        tokenContract.transfer(msg.sender, _numberOfToken * 10 ** 18);

        tokenSold += _numberOfToken;

        emit Sell(msg.sender, _numberOfToken); 
    }

    function endSale() public {
        require(msg.sender == admin);
        require(tokenContract.transfer(admin, tokenContract.balanceOf(address(this))));

        payable(admin).transfer(address(this).balance);
    }

}
