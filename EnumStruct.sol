// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.4;

contract EnumStruct {
    enum Color {
        Green, Red, Orange, Blue,
        Purple, White, Black
        }
    struct CarProperties{
        uint32 engineCapacity;
        uint32 wheelsSize;
        uint32 doorAmount;
        bool allWheelsDrive;
        Color carColor;
    }
    CarProperties[] public cars;
    //Как я понял indexed нужен для того, чтобы проще было искать по 
    //логам нужную информацию. Тут это не обязательно по моему мнению
    //так как всего одно поле в логи отправляем.
    event AddCar(address indexed sender);

    function createCar(
        uint32 _engineCap,
        uint32 _wheelsSize, 
        uint32 _doorAmount, 
        bool _allWheelsDrive,
        Color _carColor
    )
        external
    {
        cars.push(CarProperties({
            engineCapacity:_engineCap,
            wheelsSize: _wheelsSize,
            doorAmount: _doorAmount,
            allWheelsDrive: _allWheelsDrive,
            carColor: _carColor
            }
        ));
        emit AddCar(msg.sender);
    }

    function editCarProperty(
        uint256 _carId, 
        uint32 _engineCap,
        uint32 _wheelsSize, 
        uint32 _doorAmount, 
        bool _allWheelsDrive,
        Color _carColor
    )
    external
    {
        require(_carId <= cars.length);
        cars[_carId].engineCapacity = _engineCap;
        cars[_carId].wheelsSize = _wheelsSize;
        cars[_carId].doorAmount = _doorAmount;
        cars[_carId].allWheelsDrive = _allWheelsDrive;
        cars[_carId].carColor = _carColor;
    }

// Вот тут не очень понял как правильнее по Style Guide сделать 
    function showCar(uint256 _carId) external view 
        returns(
            uint32, 
            uint32, 
            uint32, 
            bool, 
            string memory
            )
    {
        require(_carId <= cars.length);
        string memory color = "";
        //Хотел бы сделать чтобы и при создании и обработке можно было задавать 
        //цвет строкой, но думаю тогда было проще сделать цвет строкой 
        if (cars[_carId].carColor == Color.Black) color = "Black";
        if (cars[_carId].carColor == Color.Blue) color = "Blue";
        if (cars[_carId].carColor == Color.Green) color = "Green";
        if (cars[_carId].carColor == Color.Orange) color = "Orange";
        if (cars[_carId].carColor == Color.Purple) color = "Purple";
        if (cars[_carId].carColor == Color.Red) color = "Red";
        if (cars[_carId].carColor == Color.White) color = "White";
        //Прочитал, что можно включить ABIEncoderV2, но так как это эксперементальная 
        //функция, пока лучше отдавать структуру так:
        return (
            cars[_carId].engineCapacity, cars[_carId].wheelsSize,
            cars[_carId].doorAmount, cars[_carId].allWheelsDrive,
            color
            );
    }
}