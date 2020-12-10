pragma solidity 0.6.12;

contract task_4 {
    mapping (address=>mapping(uint=>bool)) deposit_type;

    function addDepositType(address _user, uint _type, bool _premition ) external {
        deposit_type[_user][_type]=_premition;
    }

    function getDepositType(address _user, uint _type) external view returns(bool) {
        return deposit_type[_user][_type];
    }

}