// SPDX-License-Identifier: MIT
// pragma solidity ^0.8.8;
pragma solidity >=0.7.0 <0.9.0;

contract Parent {
    string name;
    uint age;

    // If the base constructors have arguments, derived contracts need to specify all of them.
    constructor(string memory _name, uint _age) {
        name = _name;
        age = _age;
    }
}

// the arguments can be specified either
// directly in the inheritance list

contract Child1 is Parent("_jongbo", 99) {
    constructor() {}
}

// or through a modifier of the derived constructor
contract Child2 is Parent {
    constructor() Parent("Blessing", 85) {}
}

// or declare abstract
abstract contract Child3 is Parent {}

// and have the next concrete derived contract initialize it.
contract Child6 is Child3 {
    constructor() Child3("Ademola", 90) {}
}