// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.6.12;

contract task_6 {
    mapping (address=>uint256) userDeposit; 
    address payable private owner;

    constructor() public {
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner);
        _;
    }

    modifier unitCheck(string memory unit) {
        require(
            keccak256(bytes(unit)) == keccak256("w") || 
            keccak256(bytes(unit)) == keccak256("g") || 
            keccak256(bytes(unit)) == keccak256("s") ||
            keccak256(bytes(unit)) == keccak256("f") || 
            keccak256(bytes(unit)) ==keccak256("e")
            ); // не знаю можно ли так форматировать, но длинная строка мне была совсем не по душе
        _;
    }

    function unitType(string memory _unit, uint256 _deposit) internal pure returns(uint256) {
        uint256 conv_dep;
        if (keccak256(bytes(_unit)) == keccak256("w")) {
            conv_dep = _deposit;
        } else if (keccak256(bytes(_unit)) == keccak256("g")) {
            conv_dep = _deposit*1e9;
        } else if (keccak256(bytes(_unit)) == keccak256("s")) {
            conv_dep = _deposit*1e12;
        } else if (keccak256(bytes(_unit)) == keccak256("f")) {
            conv_dep = _deposit*1e15;
        } else if (keccak256(bytes(_unit)) == keccak256("e")) {
            conv_dep = _deposit*1e18;
        }
        // понимаю, что такое решение не самое красивое, но я так понял, что с дробными числами solidity не очень дружит, по этому реализовал возможность вводить значения в разных единицах 
        return conv_dep;
    }

    function store() external payable{
        require(msg.value > 0);
        userDeposit[msg.sender] = userDeposit[msg.sender] + msg.value;
    }

    function ownerReceive(uint256 _deposit, string memory _unit) unitCheck(_unit) external onlyOwner{
        uint256 conv_dep = unitType(_unit, _deposit);
        require(conv_dep <= userDeposit[owner]);
        owner.transfer(conv_dep);
        userDeposit[owner] = userDeposit[owner] - conv_dep;
    }
    
    function userReceive(uint256 _deposit, string memory _unit) unitCheck(_unit) external {
        uint256 conv_dep = unitType(_unit, _deposit);
        require(conv_dep <= userDeposit[msg.sender]);
        msg.sender.send(conv_dep); //ругается на то, что send() возвращает не ошибку, а false
        userDeposit[msg.sender] = userDeposit[msg.sender] - conv_dep;
    }

    function getUserDeposit(address _user) view external returns(uint256){
       return userDeposit[_user]; // тут решил показывать в веях, хотя можно реализовать такую же схему, как и в Recive
    }

    function getYourDeposit() view external returns(uint256){
       return userDeposit[msg.sender]; // тут решил показывать в веях, хотя можно реализовать такую же схему, как и в Recive
    }
}