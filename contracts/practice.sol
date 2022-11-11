pragma solidity ^0.8.2;


contract Bank{

    mapping (address => uint ) balance;
    address owner;

    event BalanceAdded (uint amount , address DepositedTo);

    modifier onlyowner{
        require (owner==msg.sender, "You Are Not The Owner");
        _;
    }

    constructor (){
        owner=msg.sender;
    }

    function Deposit() public payable returns (uint){
        balance [msg.sender] +=  msg.value;
        emit BalanceAdded (msg.value , msg.sender);
        return balance [msg.sender];
    }

    function withdraw(uint Amount) public {
        address recipient = 0xAb8483F64d9C6d1EcF9b849Ae677dD3315835cb2;
        payable(recipient).transfer(Amount);
        emit BalanceAdded (Amount, recipient);  
    }

    function AddBalance (uint _toadd) public {
        balance [msg.sender] += _toadd;
        emit BalanceAdded (_toadd, msg.sender);
    }

    function GetBalance() public view returns (uint){
        return balance[msg.sender];
    }

    function Transfer(address recipient ,  uint Amount) public onlyowner{

        require (balance [msg.sender]>= Amount , "You Dont Have Enough Balance");
        require (msg.sender != recipient);

        uint PreviousSenderBalance= balance [msg.sender];
        balance [msg.sender] -= Amount;
        balance [recipient] += Amount;
        assert (balance [msg.sender]==PreviousSenderBalance - Amount);
    }

}
