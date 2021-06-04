pragma solidity ^0.6.0;

// SPDX-License-Indentifier: MIT

// import "./SafeMath.sol";
import "@openzeppelin/contracts/math/SafeMath.sol";

contract JaredToken {

  using SafeMath for uint256;

  string public name;
  string public symbol;
  uint256 public decimals;
  uint256 public totalSupply;

  mapping (address => uint256) balances;
  mapping (address => mapping(address => uint256)) allowed;

  event Transfer(address _from, address _to, uint256 _value);
  event Approval(address _owner, address _spender, uint256 _value);

  constructor (
    string memory _name,
    string memory _symbol,
    uint256 _decimals,
    uint256 _totalSupply
  )
    public
  {
    name = _name;
    symbol = _symbol;
    decimals = _decimals;
    totalSupply = _totalSupply;
    balances[msg.sender] = _totalSupply;
    emit Transfer(address(0), msg.sender, _totalSupply);
  }

  function balanceOf (address _owner) public view returns (uint256) {
    return balances[_owner];
  }

  function _transfer (address _from, address _to, uint256 _value) internal {
    require(balances[_from] >= _value, "Not Enough balance");
    balances[_from] = balances[_from].sub(_value);
    balances[_to] = balances[_to].add(_value);

    emit Transfer(_from, _to, _value);
  }

  function transfer (address _to, uint256 _value) public returns (bool) {
    _transfer(msg.sender, _to, _value);

    return true;
  }

  function transferFrom (address _from, address _to, uint256 _value) public returns (bool) {
    require(allowed[_from][msg.sender] >= _value, "Not Enough allowance");
    allowed[_from][msg.sender] = allowed[_from][msg.sender].sub(_value);
    _transfer(_from, _to, _value);

    return true;
  }

  function approve (address _spender, uint256 _value) public returns (bool) {
    allowed[msg.sender][_spender] = _value;

    emit Approval(msg.sender, _spender, _value);

    return true;
  }

  function allowance (address _owner, address _spender) public view returns (uint256) {
    return allowed[_owner][_spender];
  }

  function revertExamples(uint a) external {
    require(a != 2, "is two");
    require(a != 3); // dev: is three
    require(a != 4, "cannot be four"); // dev: is four
    require(a != 5); // is five
  }
}
