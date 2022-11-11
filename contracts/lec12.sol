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

    function deposit() public payable returns(uint){
        balance[msg.sender] += msg.value;                   
        emit balanceAdded(msg.value, msg.sender);
        return balance[msg.sender];
    }

    function withdrawal(uint amount) public {
        require(balance[msg.sender] >= amount, "You dont have enought balance to send");
        
        payable(msg.sender).transfer(amount);
        uint previousBalance = balance[msg.sender];
        balance[msg.sender] -= amount;
        
        assert(balance[msg.sender] == previousBalance - amount);
        
    }

    function getBalance() public view returns(uint){
        return balance[msg.sender];
    }

    function totalBalance() public view returns(uint){        // Return the all balance of different account of contract
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
