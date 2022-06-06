// SPDX-License-Identifier: MIT
// pragma solidity ^0.6.0;
pragma solidity ^0.8.0;

// comment out either contract to test the other

// // all this happened in version lower than 0.8.0
// contract SafeMathTester {
//     // the maximum of uint8 is 255. Adding any number to this will cause an overflow which will lead to resetting it to 0 plus extra num.
//     // e.g if bigNumber is 255 and 11 is added. it'll reset to 10. 255 + 1 reset it to 0. subtract the 1 from 11 gives 10
//     // if bigNum is 250 and 45 is added, 250 + 6 gives 0. subtract 6 from 45 = 39. this means bigNum reset to 39
//     // all the above is called overflow
//     uint8 public bigNumber = 255;

//     // the same procedure applies to underflow
//     // if smallNumnber is 1 and 45. 1 - 1 = 0 = 256(base), subtract 1 from 45 gives 44. 256 - 44 = 212
//     uint8 public smallNumber = 1; // the minimum of uint8 is 0. Subtracting any number from it will cause an underflow which will lead to resetting it to 255

//     function add(uint8 val) public {
//         bigNumber += val;
//     }

//     function subtract(uint8 val) public {
//         smallNumber -= val;
//     }
// }

// starting from version >= 0.8.0
contract SafeMathTesterTwo {
    uint8 public bigNumber = 255;

    uint8 public smallNumber = 1;

    function add(uint8 val) public {
        // overflow causes an error
        bigNumber += val;
    }

    function subtract(uint8 val) public {
        // underflow causes an error
        smallNumber -= val;
    }

    function addNotCare(uint8 val) public {
        // using unchecked now switches to the behaviour in versions less than 0.8.0
        // you will want to use unchecked because it makes our code a little bit gas efficient.
        // So it can be used when we're very positive that overflow/underflow won't happen 
        unchecked { bigNumber += val; }
    }

    function subtractNotCare(uint8 val) public {
        unchecked { smallNumber -= val; }
    }
}