// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.12;

contract first {
    function _addition(int256 _a, int256 _b) internal pure returns(int256) {
       return (_a + _b);
    }

    function _subtraction(int256 _a, int256 _b) internal pure returns(int256) {
       return (_a - _b);
    }
}

