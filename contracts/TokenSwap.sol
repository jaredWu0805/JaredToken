// SPDX-License-Identifier: MIT
pragma solidity ^0.6.0;

import "@openzeppelin/contracts/math/SafeMath.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract TokenSwap {

  IERC20 public token1;
  IERC20 public token2;
  address public owner1;
  address public owner2;
  uint public owner1Amount;
  uint public owner2Amount;

  constructor (
    address _token1,
    address _token2,
    address _owner1,
    address _owner2,
    uint _owner1Amount,
    uint _owner2Amount
  ) public {
    token1 = IERC20(_token1);
    token2 = IERC20(_token2);
    owner1 = _owner1;
    owner2 = _owner2;
    owner1Amount = _owner1Amount;
    owner2Amount = _owner2Amount;
  }

  function swap() public {
    require(msg.sender == owner1 || msg.sender == owner2, "Not owner");
    require(
      token1.allowance(owner1, address(this)) >= owner1Amount,
      "Has no enough allowance of token1 for owner1"
    );
    require(
      token2.allowance(owner2, address(this)) >= owner2Amount,
      "Has no enough allowance of token2 for owner2"
    );

    _tranferFrom(token1, owner1, owner2, owner1Amount);
    _tranferFrom(token2, owner2, owner1, owner2Amount);
  }

  function _tranferFrom(
    IERC20 token,
    address _from,
    address _to,
    uint amount
  ) private {
    bool sent = token.transferFrom(_from, _to, amount);
    require(sent, "Token transfer failed");
  }
}
