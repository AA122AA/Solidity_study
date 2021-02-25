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

    event AddCar(
        address indexed sender,
        uint32 engineCap,
        uint32 wheelsSize, 
        uint32 doorAmount, 
        bool allWheelsDrive,
        Color carColor
    );

    event EditCar(
        address indexed sender,
        uint256 indexed carId, 
        uint32 engineCap,
        uint32 wheelsSize, 
        uint32 doorAmount, 
        bool allWheelsDrive,
        Color carColor
    );

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
            engineCapacity: _engineCap,
            wheelsSize: _wheelsSize,
            doorAmount: _doorAmount,
            allWheelsDrive: _allWheelsDrive,
            carColor: _carColor
            }
        ));

        emit AddCar(
            msg.sender,
            _engineCap,
            _wheelsSize, 
            _doorAmount, 
            _allWheelsDrive,
            _carColor
        );
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

        emit EditCar(
            msg.sender,
            _carId,
            _engineCap,
            _wheelsSize, 
            _doorAmount, 
            _allWheelsDrive,
            _carColor
        );
    }

    function colorChoice(uint256 _carId) private view returns(string memory){
        string memory color = "";
        if (cars[_carId].carColor == Color.Black) color = "Black";
        if (cars[_carId].carColor == Color.Blue) color = "Blue";
        if (cars[_carId].carColor == Color.Green) color = "Green";
        if (cars[_carId].carColor == Color.Orange) color = "Orange";
        if (cars[_carId].carColor == Color.Purple) color = "Purple";
        if (cars[_carId].carColor == Color.Red) color = "Red";
        if (cars[_carId].carColor == Color.White) color = "White";
        return color;
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
        string memory color = colorChoice(_carId);
        return (
            cars[_carId].engineCapacity, cars[_carId].wheelsSize,
            cars[_carId].doorAmount, cars[_carId].allWheelsDrive,
            color
            );
    }

}