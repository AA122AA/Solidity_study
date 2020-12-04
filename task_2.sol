pragma solidity 0.5.1;

contract Uint_type{
    uint8 number;
    function set_number(uint8 _number) public {
        number = _number; 
    }

    function get_number() public view returns(uint8) {
       return number; 
    }
}