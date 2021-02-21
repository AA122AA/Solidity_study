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
    //Как я понял indexed нужен для того, чтобы проще было искать по 
    //логам нужную информацию. Тут это не обязательно по моему мнению
    //так как всего одно поле в логи отправляем.
    event AddCar(address indexed sender);

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
        emit AddCar(msg.sender);
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
        require(_carId < cars.length);
        cars[_carId].engineCapacity = _engineCap;
        cars[_carId].wheelsSize = _wheelsSize;
        cars[_carId].doorAmount = _doorAmount;
        cars[_carId].allWheelsDrive = _allWheelsDrive;
    }

    function showCar(uint256 _carId) external view returns(uint32, uint32, uint32, bool){
        require(_carId < cars.length);
        //Прочитал, что можно включить ABIEncoderV2, но так как это эксперементальная функция, пока лучше отдавать структуру так:
        return (cars[_carId].engineCapacity, cars[_carId].wheelsSize, cars[_carId].doorAmount, cars[_carId].allWheelsDrive);
    }
}