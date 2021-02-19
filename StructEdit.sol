// SPDX-License-Identifier: GPL-3.0
pragma solidity ^0.7.4;

contract StructEdit {
    struct CarProperties{
        uint32 engineCapacity;
        uint32 wheelsSize;
        uint32 doorAmount;
        bool allWheelsDrive;
    }
    CarProperties[] public cars;

    function createCar(
        uint32 _engineCap,
        uint32 _wheelsSize, 
        uint32 _doorAmount, 
        bool _allWheelsDrive
    )
        external
    {
        cars.push(CarProperties({
            engineCapacity:_engineCap,
            wheelsSize: _wheelsSize,
            doorAmount: _doorAmount,
            allWheelsDrive: _allWheelsDrive
            }
        ));
    }

    function editCarProperty(
        uint256 _carId, 
        uint32 _engineCap,
        uint32 _wheelsSize, 
        uint32 _doorAmount, 
        bool _allWheelsDrive
    )
    external
    {
        cars[_carId].engineCapacity = _engineCap;
        cars[_carId].wheelsSize = _wheelsSize;
        cars[_carId].doorAmount = _doorAmount;
        cars[_carId].allWheelsDrive = _allWheelsDrive;
    }
}