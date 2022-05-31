// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "./SimpleStorage.sol";

contract StorageFactory {
    SimpleStorage[] public simpleStorageArray;

    function createSimpleStorageContract() public {
        // new keyword is used to deploy a contract
        SimpleStorage simpleStorage = new SimpleStorage(); // address of this new contract is returned
        simpleStorageArray.push(simpleStorage);
    }

    // calling the changeNumber of SimpleStorage contract
    function sfStore(uint256 _simpleStorageIndex, uint256 _simpleStorageNumber) public {
        // deployed contracts have address and ABI
        // ABI - Applcation Binary Interface. This tell our code how we can interact with a contract

        // retrieve one of deployed SimpleStorage contracts
        SimpleStorage sStorage = simpleStorageArray[_simpleStorageIndex];

        // you can now call any of its method
        sStorage.changeNumber(_simpleStorageNumber);
    }

    // calling getHiddenByDefault of SimpleStorage contract
    function sfGet(uint256 _simpleStorageIndex) public view returns(uint256) {
        return simpleStorageArray[_simpleStorageIndex].getHiddenByDefault();
    }

    // calling getScoreAndHiddenByDefault of SimpleStorage contract
    function sfRetrieve(uint256 _simpleStorageIndex) public view returns(uint256, uint256) {
        return simpleStorageArray[_simpleStorageIndex].getScoreAndHiddenByDefault();
    }
}