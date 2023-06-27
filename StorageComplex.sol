//SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract StorageComplex {
    uint256[3] public fixedArray;
    uint256[] public bigArray;
    uint16[] public smallArray;

    mapping(uint256 => uint256) public myMapping;
    mapping(uint256 => mapping(uint256 => uint256)) public nestedMapping;
    mapping(address => uint256[]) public addressToList;


    constructor() {
        fixedArray = [99, 999, 9999];
        bigArray = [10, 20, 30, 40];
        smallArray = [1, 2, 3, 4, 5];
        myMapping[10] = 5;
        myMapping[11] = 6;
        nestedMapping[1][2] = 777;
        addressToList[0x5B38Da6a701c568545dCfcB03FcB875f56beddC4] = [19, 23, 29];
    }

    function viewFixedArray(uint256 index) external view returns (uint256 ret) {
        assembly {
            ret := sload(add(fixedArray.slot, index))
        }
    }

    function bigArrayLength() external view returns (uint256 ret) {
        assembly {
            ret := sload(bigArray.slot)
        }
    }

    function readBigArrayLocation(uint256 index) external view returns (uint256 ret) {
        uint256 slot;
        assembly {
            slot := bigArray.slot
        }
        bytes32 location = keccak256(abi.encode(slot));
        assembly {
            ret := sload(add(location, index))
        }
    }

    function readSmallArrayLength() external view returns (uint256 ret) {
        assembly {
            ret := sload(smallArray.slot)
        }
    }

    function readSmallArray(uint256 index) external view returns (uint256 ret) {
        uint256 slot;
        assembly {
            slot := smallArray.slot
        }
        bytes32 location = keccak256(abi.encode(uint256(slot)));
        assembly {
            ret := sload(add(location, index))
        }
    }

    function viewMyMapping(uint256 key) external view returns (uint256 ret) {
        uint256 slot;
        assembly {
            slot := myMapping.slot
        }
        bytes32 location = keccak256(abi.encode(key, slot));
        assembly {
            ret := sload(location)
        }
    }

    function viewNestedMapping(uint256 key1, uint256 key2) external view returns (uint256 ret) {
        uint256 slot;
        assembly {
            slot := nestedMapping.slot
        }
        bytes32 location = keccak256(abi.encode(key2, keccak256(abi.encode(key1, slot))));
        assembly {
            ret := sload(location)
        }
    }

    function getAddressToList(address user, uint256 index) external view returns (uint256 ret) {
        uint256 slot;
        assembly {
            slot := addressToList.slot
        }
        bytes32 location = keccak256(abi.encode(keccak256(abi.encode(user, slot))));
        assembly {
            ret := sload(add(location, index))
        }
    }
}
