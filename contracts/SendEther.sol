// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract ReceiveEther {

  event ReceiveLog(address caller, uint amount, uint gas, string message);

  fallback() external payable {
      emit ReceiveLog(msg.sender, msg.value, gasleft(), "Fallback Called");
  }

  function getBalance() public view returns (uint) {
    return address(this).balance;
  }
}

contract SendEther {

  event SendLog(uint gas);

  function sendViaTranfer(address payable _to) public payable {
    _to.transfer(msg.value);
  }

  function sendViaSend(address payable _to) public payable {
    bool sent = _to.send(msg.value);
    require(sent, "Failed to send Ether");
  }

  function sendViaCall(address payable _to) public payable {
    (bool sent, bytes memory data) = _to.call{value: msg.value, gas: 5000}("");
    emit SendLog(gasleft());
    require(sent, "Failed to send Ether");
  }
}
