 // SPDX-License-Identifier: No License
pragma solidity ^0.8.3;

contract Election {

    struct Candidate {
        string ChairmanName;
        string partyName;
        string partySymbol;
        uint date;
        uint voteCount;
    }

    address owner;

    constructor() {
        owner = msg.sender;
    }

    mapping(uint => Candidate) public Candidates;
    uint nextId;

    function createCandidate(string memory ChairmanName, string memory partyName, string memory partySymbol, uint date) external {
        require(owner == msg.sender, "Only Election Commission can call this function");

        Candidates[nextId] = Candidate(ChairmanName, partyName, partySymbol, date, 0);
        nextId++;
    }

    mapping(address => mapping(uint => bool)) Vote;
    mapping(address => bool) voted;

    function Voter(uint id) external {
        require(Vote[msg.sender][id] == false, "You already voted");
        require(voted[msg.sender] == false, "You already vote to any party");
        require(Candidates[id].date>block.timestamp,"Election has been end");

        Vote[msg.sender][id] = true;
        voted[msg.sender] = true;
        Candidates[id].voteCount++;
    }

}
