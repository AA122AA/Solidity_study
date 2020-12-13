// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.12;

contract first {
    function addition(int256 _a, int256 _b) internal pure returns(int256) {
       return (_a + _b);
    }

    function subtraction(int256 _a, int256 _b) internal pure returns(int256) {
       return (_a - _b);
    }
}

contract second is first{
  function isBiggerZeroAdd(int256 _a, int256 _b) public pure returns(bool state, int256 res){
    res = addition(_a, _b);
    if (res > 0) {
        state = true;
    } else {
        state = false;
    }
  }  
  function isBiggerZeroSub(int256 _a, int256 _b) public pure returns(bool state, int256 res){
    res = subtraction(_a, _b);
    if (res > 0) {
        state = true;
    } else {
        state = false;
    }
  }
}
