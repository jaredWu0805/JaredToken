// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

contract Test {
  uint public number;
  uint private secretNum;

  constructor (uint _number, uint _secretNum) public {
    number = _number;
    secretNum = _secretNum;
  }

  function getSecretNum() public view returns (uint) {
    return secretNum;
  }

  function setNumber(uint _number) public {
    number = _number;
  }
}

interface ITest {
  function number() external view returns (uint);
  function setNumber(uint _number) external;
  function getSecretNum() external view returns (uint);
}

contract Main {
  function getTestSecret(address _test) public view returns (uint) {
    return ITest(_test).getSecretNum();
  }

  function getNumber(address _test) public view returns (uint) {
    return ITest(_test).number();
  }

  function setTestNumber(address _test, uint _number) public returns (bool) {
    ITest(_test).setNumber(_number);
    return true;
  }
}
