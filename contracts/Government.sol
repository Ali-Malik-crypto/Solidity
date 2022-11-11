pragma solidity ^0.7.5;

contract Government {

    struct Transaction{
    address from;
    address to;
    uint amount;
    uint trxID;
    }

    Transaction[] transactionlog;
    function addTransaction(address from, address to, uint amount) external {
        Transaction memory _transaction = Transaction(from, to, amount, transactionlog.length);
        transactionlog.push(_transaction);
    }

    function getTransaction(uint _index) public view returns(address, address, uint){
        return (transactionlog[_index].from, transactionlog[_index].to, transactionlog[_index].amount);
    }

}
