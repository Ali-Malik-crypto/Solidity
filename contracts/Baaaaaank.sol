pragma solidity ^0.7.3;

interface GovernmentInterface {
    function addTransaction(address from, address to, uint amount) external;
}

contract Ownable {

    address public owner;

    constructor() {
        owner = msg.sender;
    }

    modifier OnlyOwner {
        require(owner == msg.sender, "You are not sender");
        _;
    }
}

contract Bank is Ownable { 

    GovernmentInterface governmentInstance = GovernmentInterface(0xD7ACd2a9FD159E69Bb102A1ca21C9a3e3A5F771B);

    mapping(address => uint) balance;


    function deposit() public payable returns(uint){
        balance[msg.sender] += msg.value;                   
        return balance[msg.sender];
    }

    function withdrawal(uint amount) public OnlyOwner returns(uint){
        require(balance[msg.sender] >= amount, "You dont have enought balance to send");
        msg.sender.transfer(amount);
        balance[msg.sender] -= amount;
        return balance[msg.sender];       
    }

    function checkBalance() public view returns(uint){
        return balance[msg.sender];
    }

    function getOwner() public view returns(address){
        return owner;
    }

    function transfer(address payable recipient, uint amount) public {
        require(balance[msg.sender] >= amount, "You dont have enought balance to send");
        require(msg.sender != recipient, "You are sender and reciever both so its not possible");


        recipient.transfer(amount);

        governmentInstance.addTransaction(msg.sender, recipient, amount);

        
    }

}
