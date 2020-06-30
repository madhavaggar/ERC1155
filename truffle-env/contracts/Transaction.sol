pragma solidity ^0.5.0;

contract Transaction {

    // model a member
    struct Member {
        address memberAddress;
        string pan;
        uint points;
        uint accBalance;
        bool isRegistered;
    }

    // model points transaction
    enum TransactionType { Earned, Redeemed }
    struct PointsTransaction {
        uint points;
        TransactionType transactionType;
        address memberAddress;
        string pan;
    }

    //members and partners on the network mapped with their address
    mapping(address => Member) public members;

    PointsTransaction[] public transactionsInfo;


    //register sender as member
    function registerMember (string memory _pan) public {
      //check msg.sender in existing members
      require(!members[msg.sender].isRegistered, "Account already registered as Member");

      //add member account
      members[msg.sender] = Member(msg.sender, _pan, 0, 10000, true);
    }

    //update member with points earned
    function earnPoints (uint _points ) public {
      // only member can call
      require(members[msg.sender].isRegistered, "Sender not registered as Member");

      require(members[msg.sender].accBalance >= _points*100, "Not enough Account Balance");

      // update member account
      members[msg.sender].points = members[msg.sender].points + _points;
      members[msg.sender].accBalance = members[msg.sender].accBalance - _points*100;

      // add transction
      transactionsInfo.push(PointsTransaction({
        points: _points,
        transactionType: TransactionType.Earned,
        memberAddress: members[msg.sender].memberAddress,
        pan: members[msg.sender].pan
      }));

    }

    //update member with points used
    function usePoints (uint _points) public {
      // only member can call
      require(members[msg.sender].isRegistered, "Sender not registered as Member");

      // verify enough points for member
      require(members[msg.sender].points >= _points, "Insufficient points");

      // update member account
      members[msg.sender].points = members[msg.sender].points - _points;
      members[msg.sender].accBalance = members[msg.sender].accBalance + _points*100;

      // add transction
      transactionsInfo.push(PointsTransaction({
        points: _points,
        transactionType: TransactionType.Redeemed,
        memberAddress: members[msg.sender].memberAddress,
        pan: members[msg.sender].pan
      }));
    }

    //get length of transactionsInfo array
    function transactionsInfoLength() public view returns(uint256) {
        return transactionsInfo.length;
    }

}
