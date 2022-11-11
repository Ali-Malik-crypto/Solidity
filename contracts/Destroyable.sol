pragma solidity ^0.7.3;

contract Storage {
    address payable public owner;
    mapping (address => uint) check;
    uint256 number;

    constructor(){
        owner = msg.sender;
    }

    // function store(uint256 num) public {
    //     number = num;
    // }

    function deposit() public payable returns(uint){
        check[msg.sender] += msg.value;                   
        // emit balanceAdded(msg.value, msg.sender);
        return check[msg.sender];
    }

    // function transfer() public {
    //     require(owner == msg.sender, "You are not owner");
    //     payable(owner).transfer(address(this).balance);
    //     uint previousBalance = check[owner];
    //     check[owner] += address(this).balance;
    //     address(this).balance == 0;
    //     assert(check[owner] == previousBalance + address(this).balance);
    // }

    function getBalance() public view returns(uint){
        return check[msg.sender];
    }

    // function retrieve() public view returns (uint256) {
    //     return number;
    // }

    function totalBalance() public view returns(uint){        // Return the all balance of different account of contract
        return address(this).balance;
    }

    function close() public {
        require(owner == msg.sender, "You are not owner");
        selfdestruct(payable(owner));
    }
}
