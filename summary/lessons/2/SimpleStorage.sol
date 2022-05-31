// SPDX-License-Identifier: MIT
pragma solidity ^0.8.8;

contract SimpleStorage {
    // types in solidity
    bool alive = true;

    // positive integers only
    // default value is 0;
    uint256 score = 25; 

    // both positive and negative
    int256 negative = -25;

    string name = "Blessing";
    address myAddress= 0x4FbAaa66fDf48bDDBC155964eaac50c004157b11;
    bytes32 favoriteBytes = "cat";

    // both initialize to 0
    uint256 hiddenByDefault; // this variable is hidden(internal) by default
    uint256 public newScore;

    function changeNumber(uint256 _number) public {
        hiddenByDefault = _number; 
        newScore = _number;

        // the more complex your function is, the more gas you spend
        hiddenByDefault = hiddenByDefault + 1;
        newScore = newScore + 1;
    }

    // this won't cost any gas cause it's a pure function
    // can't access and modify any state cause it's pure
    function add(uint256 _a, uint256 _b) public pure returns(uint256) {
        return (_a + _b);
    }

    // won't cost gas cause of 'view' modifier
    // can access but can not modify any state
    function checkScore() public view returns(uint256) {
        return newScore;
    }

    function getHiddenByDefault() public view returns(uint256) {
        return hiddenByDefault;
    }

    function getScoreAndHiddenByDefault() public view returns(uint256, uint256) {
        return (checkScore(), getHiddenByDefault());
    }

    function costGas(uint256 _a, uint256 _b) public {
        // these 2 will cost gas because they are called in a function that costs gas
        uint256 added = add(_a, _b);
        changeNumber(added); // this costs gas which enables the add function to cost gas
        checkScore();
    }

    function wontCostGas() public pure returns(uint256){
        uint256 solve  = add(20, 30);
        return solve;
    }

    // STRUCTS AND ARRAYS
    // A struct is like an object in javascript
    struct Person {
        string name;
        uint8 age; // uint<n> where n = 8, 16, 32, 64, 128, 256 ranges from (2 ^ n) - 1.
        // I used uint8 here because technically, a person cannot be older than 150 at this modern time,
        // so sad
        bool alive;
        uint256 favoriteNumber;
    }

    Person public Blessing = Person("Blessing", 21, true, 2024); // this must be in the order in which Person is defined
    Person public Yinka = Person({name: "Yinka", favoriteNumber: 9870, age: 22, alive: true}); // this can be any order with the correct parameter name
    Person public Hitler = Person("Hitler", 56, false, 1945);

    // ARRAYS
    Person[] public people; // dynamic array -- it can be of any length
    uint8[4] public randomNumbers; // fixed array -- it can have a maximum length of 4

    // storing "stuff" -- calldata, memory, storage
    // calldata and memory are temporary, they are only available during function execution
    // storage stays permanent on the blockchain
    function addPerson(string memory _name, uint8 _age, bool _alive, uint256 _favouriteNumber) public {
        people.push(Person(_name, _age, _alive, _favouriteNumber)); 
    }

    // calldata -- parameters assigned to this cannot be changed
    // memory -- parameters assigned to this can be changed

    // function callDataF(string calldata _name) public {
    //     _name = "war"; // throws an error
    // }

    // function memoryF(string memory _name) public {
    //     _name = "peace"; // no error
    // }

    // Solidity knows that other data types except array, struct and mappings are assigned to memory.
    // Specifying the data location to these other types will result to error
    // strings need to specified because strings are "array" of bytes.

    // function whenToUse(string memory _name, uint8 memory _age, bool memory _alive) public {
    //     // error will be thrown cause you specified the data location for bool and unit8

    // }

    // MAPPINGS
    mapping(string => uint256) public nameToFavouriteNumber;
    // the above is like a key which is string to a value which is uint256

    function addPersonWithMap(string memory _name, uint8 _age, bool _alive, uint256 _favouriteNumber) public {
        addPerson(_name, _age, _alive, _favouriteNumber);
        nameToFavouriteNumber[_name] = _favouriteNumber;
    }

    // Deployin to contract
}