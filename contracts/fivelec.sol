pragma solidity ^0.7.3;

contract Mapping {

    mapping(address => uint) public testmapping;

    function setbalance(address _address, uint _amount) public{
        testmapping[_address] = _amount;
    }

}
