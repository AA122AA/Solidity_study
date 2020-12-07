pragma solidity 0.5.1;

contract task_3{
    int[] arr;

    //Добавляем новый элемент массива в конец 
    function addToArray(int num) public{
        arr.push(num);
    }

    //Удаляем последний элемент в масиве 
    function deleteFromArray() public{
        arr.pop();
    }

    function getArray(int i) public view returns(int[] memory) {
        return arr;
    }


}