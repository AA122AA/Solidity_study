// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.4;

contract WhileFor {
    enum Color {
        Green, Red, Orange, Blue,
        Purple, White, Black
        }
    struct CarProperties{
        uint32 engineCapacity;
        uint32 wheelsSize;
        uint32 doorAmount;
        uint256 mileage;
        uint256 age;
        bool allWheelsDrive;
        Color carColor;
    }
    CarProperties[] public cars;

    event AddCar(
        address indexed sender,
        uint32 engineCap,
        uint32 wheelsSize, 
        uint32 doorAmount, 
        uint256 mileage,
        uint256 age,
        bool allWheelsDrive,
        Color carColor
    );

    event EditCar(
        address indexed sender,
        uint256 indexed carId, 
        uint32 engineCap,
        uint32 wheelsSize, 
        uint32 doorAmount, 
        uint256 mileage,
        uint256 age,
        bool allWheelsDrive,
        Color carColor
    );

    function createCar(
        uint32 _engineCap,
        uint32 _wheelsSize, 
        uint32 _doorAmount, 
        uint256 _mileage,
        uint256 _age,
        bool _allWheelsDrive,
        Color _carColor
    )
        external
    {
        cars.push(CarProperties({
            engineCapacity: _engineCap,
            wheelsSize: _wheelsSize,
            doorAmount: _doorAmount,
            mileage: _mileage,
            age: _age,
            allWheelsDrive: _allWheelsDrive,
            carColor: _carColor
            }
        ));

        emit AddCar(
            msg.sender,
            _engineCap,
            _wheelsSize, 
            _doorAmount, 
            _mileage,
            _age,
            _allWheelsDrive,
            _carColor
        );
    }

    function editCarProperty(
        uint256 _carId, 
        uint32 _engineCap,
        uint32 _wheelsSize, 
        uint32 _doorAmount, 
        uint256 _mileage,
        uint256 _age,
        bool _allWheelsDrive,
        Color _carColor
    )
    external
    {
        require(_carId <= cars.length);
        cars[_carId].engineCapacity = _engineCap;
        cars[_carId].wheelsSize = _wheelsSize;
        cars[_carId].doorAmount = _doorAmount;
        cars[_carId].mileage = _mileage;
        cars[_carId].age = _age;
        cars[_carId].allWheelsDrive = _allWheelsDrive;
        cars[_carId].carColor = _carColor;

        emit EditCar(
            msg.sender,
            _carId,
            _engineCap,
            _wheelsSize, 
            _doorAmount, 
            _mileage,
            _age,
            _allWheelsDrive,
            _carColor
        );
    }


    function showCar(uint256 _carId) external view 
        returns(
            uint32, 
            uint32, 
            uint32, 
            uint256, 
            uint256, 
            bool, 
            string memory
            )
    {
        require(_carId <= cars.length);
        string memory color = colorChoice(cars[_carId].carColor);
        return (
            cars[_carId].engineCapacity, cars[_carId].wheelsSize,
            cars[_carId].doorAmount, cars[_carId].mileage, cars[_carId].age,
            cars[_carId].allWheelsDrive, color
            );
    }

    function increaseCarsMileage(uint256 _mileage) external {
        require(_mileage < 1000, "Hold on, don't drive that much. 999 miles max.");
        for (uint256 i = 0; i < cars.length; i++) {
            uint256 j = 0;
            while (j != _mileage)
            {
                cars[i].mileage += 1;
                j++;
            }
        }
    }

    function increaseCarsAge(uint256 _age) external {
        require(_age < 100, "Car can't live that long");
        for (uint256 i = 0; i < cars.length; i++) {
            for (uint256 j = 0; j < _age; j++) {
                cars[i].age += 1;
            }
        }
    }

    function colorChoice(Color _carColor) private pure returns(string memory){
        string memory color = "";
        if (_carColor == Color.Black) color = "Black";
        if (_carColor == Color.Blue) color = "Blue";
        if (_carColor == Color.Green) color = "Green";
        if (_carColor == Color.Orange) color = "Orange";
        if (_carColor == Color.Purple) color = "Purple";
        if (_carColor == Color.Red) color = "Red";
        if (_carColor == Color.White) color = "White";
        return color;
    }
}