contract StorageOffset {
    uint128 public A = 1;
    uint64 public B = 2;
    uint32 public C = 3;
    uint16 public D = 4;
    uint16 public E = 5;

    function getValBySlot(uint256 slot) external view returns (bytes32 ret) {
        assembly {
            ret := sload(slot)
        }
    }

    function getOffsetE() external pure returns (uint256 offset, uint256 slot) {
        assembly {
            offset := E.offset
            slot := E.slot
        }
    }

    function readA() external view returns (uint256 ret) {
        assembly {
            let value := sload(A.slot)
            let shifted := shr(mul(A.offset, 8), value)
            ret := and(0xffffffffffffffffffffffffffffffff, shifted)
        }
    }

    function readB() external view returns (uint256 ret) {
        assembly {
            let value := sload(B.slot)
            let shifted := shr(mul(B.offset, 8), value)
            ret := and(0xffffffffffffffff, shifted)
        }
    }

    function readC() external view returns (uint256 ret) {
        assembly {
            let value := sload(C.slot)
            let shifted := shr(mul(C.offset, 8), value)
            ret := and(0xffffffff, shifted)
        }
    }

    function readD() external view returns (uint256 ret ) {
        assembly {
            let value := sload(D.slot)
            let shifted := shr(mul(D.offset, 8), value)
            ret := and(0xffff, shifted)
        }
    }

    function readE() external view returns (uint256 ret) {
        assembly {
            let value := sload(E.slot)
            let shifted := shr(mul(E.offset, 8), value)
            ret := and(0xffff, shifted)
        }
    }

    function writeA(uint128 newA) external {
        assembly {
            let _a := sload(A.slot)
            let clearedA := and(_a, 0xffffffffffffffffffffffffffffffff00000000000000000000000000000000)
            let shiftedNewA := shl(mul(A.offset, 8), newA)
            let newValue := or(shiftedNewA, clearedA)
            sstore(A.slot, newValue)
        }
    }

    function writeB(uint64 newB) external {
        assembly {
            let _b := sload(B.slot)
            let clearedB := and(_b, 0xffffffffffffffff0000000000000000ffffffffffffffffffffffffffffffff)
            let shiftedNewB := shl(mul(B.offset, 8), newB)
            let newValue := or(shiftedNewB, clearedB)
            sstore(B.slot, newValue)
        }
    }

    function writeC(uint32 newC) external {
        assembly {
            let _c := sload(C.slot)
            let clearedC := and(_c, 0xffffffff00000000ffffffffffffffffffffffffffffffffffffffffffffffff)
            let shiftedNewC := shl(mul(C.offset, 8), newC)
            let newValue := or(shiftedNewC, clearedC)
            sstore(C.slot, newValue)
        }
    }

    function writeD(uint16 newD) external {
        assembly {
            //newD = 0x000000000000000000000000000000000000000000000000000000000000ffff
            let _d := sload(D.slot)
            //_d = orignial value
            let clearedD := and(_d, 0xffff0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffff)
            let shiftedNewD := shl(mul(D.offset, 8), newD)
            let newValue := or(shiftedNewD, clearedD)
            sstore(D.slot, newValue)
        }
    }

    function writeE(uint16 newE) external returns (bytes32 ret){
        assembly {
            let _e := sload(E.slot)
            let clearedE := and(_e, 0x0000ffffffffffffffffffffffffffffffffffffffffffffffffffffffffffff)
            let shiftedNewE := shl(mul(E.offset, 8), newE)
            let newValue := or(shiftedNewE, clearedE)
            sstore(E.slot, newValue)
            ret := shiftedNewE
        }
    }

}
