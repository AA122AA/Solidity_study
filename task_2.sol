pragma solidity 0.5.1;

contract Uint_type{
    uint8 number;
    function set_number(uint8 _number) public {
        number = _number; 
    }

    function get_number() public view returns(uint8) {
       return number; 
    }
    
    function add_nums(uint8 _a, uint8 _b) public pure returns(bool){
        return (_a+_b)>_a;
    }
    
    function sub_nums(uint8 _a, uint8 _b) public pure returns(bool){
        return (_a-_b)<_a;
    }
}