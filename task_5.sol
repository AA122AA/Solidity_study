// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.12;

contract B {
    function _addition(int256 _a, int256 _b) internal pure returns(int256) {
        return (_a + _b);
    }

    function _subtraction(int256 _a, int256 _b) internal pure returns(int256) {
        return (_a - _b);
    }
}

contract A is B {
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