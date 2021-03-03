// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.4;

contract Task6 {
    mapping (address=>uint256) userDeposit; 
    address payable private owner;
    event receiveMoney(address sender, uint amount);
    event sendMoney(address sender, uint amount, string unit);

    constructor() {
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

    // Данная функция нужна для того, чтобы переводить введенный депозит в wei так как все расчеты производятся в них
    // Я решил осатвить такое решение, дабы не полагаться на сторонний софт
    function _unitType(string memory _unit, uint256 _deposit) internal pure returns(uint256) {
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

    function contractBalance() public view returns(uint256) {
        return address(this).balance;
    }

    function store() external payable{
        require(msg.value > 0);
        userDeposit[msg.sender] = userDeposit[msg.sender] + msg.value;
        emit receiveMoney(msg.sender, msg.value);
    }

    function ownerReceive(uint256 _deposit, string memory _unit) unitCheck(_unit) external onlyOwner{
        uint256 conv_dep = _unitType(_unit, _deposit);
        require(conv_dep <= userDeposit[owner]);
        require(contractBalance() >= conv_dep);
        owner.transfer(conv_dep);
        userDeposit[owner] = userDeposit[owner] - conv_dep;
        emit sendMoney(owner, _deposit, _unit);
    }
    
    function userReceive(uint256 _deposit, string memory _unit) unitCheck(_unit) external {
        uint256 conv_dep = _unitType(_unit, _deposit);
        require(conv_dep <= userDeposit[msg.sender]);
        require(contractBalance() >= conv_dep);
        bool isSend = msg.sender.send(conv_dep); //ругается на то, что send() возвращает не ошибку, а false
        if (isSend) {
            userDeposit[msg.sender] = userDeposit[msg.sender] - conv_dep;
        } 
        emit sendMoney(msg.sender, _deposit, _unit);
    }

    function getUserDeposit(address _user) view external returns(uint256){
       return userDeposit[_user]; // тут решил показывать в веях, хотя можно реализовать такую же схему, как и в Recive
    }

    function getYourDeposit() external view returns(uint256){
       return userDeposit[msg.sender]; // тут решил показывать в веях, хотя можно реализовать такую же схему, как и в Recive
    }
}