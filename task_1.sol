pragma solidity 0.5.1;

contract String_type {
    string str;
    
    function write_string(string memory _str) public {
        str = _str;
    }
    
    function read_string() public view returns(string memory){
        return str;
    }
}
