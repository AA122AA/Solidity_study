pragma solidity 0.5.1;

contract task_3{
    int[] arr;

    //Не уверен правильно ли это, но я решил добавить проверку на вводимый индекс
    modifier len(uint _i) {
        require(_i < arr.length);
        _;
    }
    //Добавляем новый элемент массива в конец 
    function addToEndArray(int num) public{
        arr.push(num);
    }

    //Удаляем последний элемент в масиве 
    function deleteLastFromArray() public{
        arr.pop();
    }

    //Удаляем конкретный элемент в масиве, но по факту этот элемент просто превращается в ноль  
    function dummDeleteFromArray(uint _i) public len(_i){
        delete arr[_i];
    }

    //Удаляем конкретный элемент в масиве. Данная функция полезна, если важно сохранять порядок в массиве. 
    function smartDeleteFromArray(uint _i) public len(_i){
        delete arr[_i];
        for (uint j = _i; j < arr.length - 1; j++) {
            arr[j] = arr[j + 1];
        } 
        arr.length--;
    }

    //Удаляем конкретный элемент в масиве. Мне кажется, что эта функция должна стоить дешевле, так как тут нет цикла.
    //Соответственно меньше требуется вычислительной мощности
    function smartDeleteFromArrayShort(uint _i) public len(_i){
        delete arr[_i];
        arr[_i]=arr[arr.length-1];
        arr.length--;
    }

    //Геттер для массива, можно было сделать его явно public, но я решил сделать отдельно геттер.
    function getArray() public view returns(int[] memory) {
        return arr;
    }
}