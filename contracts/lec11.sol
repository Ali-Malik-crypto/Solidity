pragma solidity ^0.7.3;

contract Bank {
    address owner;

    constructor() {
        owner = msg.sender;
    }

    event balanceAdded(uint256 amount, address despositedTo);
    modifier OnlyOwner() {
        require(owner == msg.sender, "You are not sender");
        _;
    }
    mapping(address => uint256) balance;
    uint public storedValue;                               // 2nd way of returning all account of balance of contract

    function deposit() public payable returns(uint){
        balance[msg.sender] += msg.value;                   
        storedValue += msg.value;                           // 2nd way of returning all account of balance of contract
        emit balanceAdded(msg.value, msg.sender);
        return balance[msg.sender];
    }

    function getBalance() public view returns(uint){
        return balance[msg.sender];
    }

    function getAllBalance() public view returns(uint){        // Return the all balance of different account of contract
        return address(this).balance;
    }

    function transfer(address recipient, uint256 amount) public OnlyOwner {
        require(
            balance[msg.sender] >= amount,
            "You dont have enought balance to send"
        );
        require(
            msg.sender != recipient,
            "You are sender and reciever both so its not possible"
        );
        uint256 previousSenderAddress = balance[msg.sender];
        balance[msg.sender] -= amount;
        balance[recipient] += amount;
        assert(balance[msg.sender] == previousSenderAddress - amount);
    }
}
