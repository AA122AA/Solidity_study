// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.12;

import "./task_5_0.sol";

contract second is first{
  function isBiggerZeroAdd(int256 _a, int256 _b) public pure returns(bool state, int256 res){
    res = _addition(_a, _b);
    if (res > 0) {
        state = true;
    } else {
        state = false;
    }
  }  
  function isBiggerZeroSub(int256 _a, int256 _b) public pure returns(bool state, int256 res){
    res = _subtraction(_a, _b);
    if (res > 0) {
        state = true;
    } else {
        state = false;
    }
  }
}