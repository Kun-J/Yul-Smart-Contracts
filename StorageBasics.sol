//SPDX-License-Identifier: MIT

pragma solidity 0.8.17;

contract StorageBasics {
    uint256 public x = 0; //stored in slot0
    uint256 public y = 7; //slot1
    uint256 public z = 9; //slot2
    uint128 public a = 1; //slot3
    uint128 public b = 2; //slot3

    function setX(uint256 newVal) external {
        x = newVal;
    }

    function getXYul() external view returns (uint256 ret) {
        assembly {
            ret := sload(x.slot)
        }
    }

    function getVarYul(uint slot) external view returns (bytes32 ret) {
        assembly {
            ret := sload(slot)
        }
    }

    function setVarYul(uint256 slot, uint256 newVal) external {
        assembly {
            sstore(slot, newVal)
        }
    }
}
