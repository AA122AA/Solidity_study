// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.4;

import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/release-v3.3/contracts/math/SafeMath.sol";

contract Task13 {

    using SafeMath for uint256;

    uint256 private a;
    uint256 private b;

    function setAB(uint256 _valueA, uint256 _valueB) external {
        a = _valueA;
        b = _valueB;
    }

    function addFuntion() external view returns(uint256 result) {
        return a.add(b);
    }

    function subFunction() external view returns(uint256 result) {
        return a.sub(b);
    }

    function mulFunction() external view returns(uint256 result) {
        return a.mul(b);
    }

    function divFunction() external view returns(uint256 result) {
        return a.div(b);
    }
}