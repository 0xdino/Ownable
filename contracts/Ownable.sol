// SPDX-License-Identifier: MIT
// author 0xDino (https://github.com/0xdino)
pragma solidity ^0.8.19;

interface IOwnable {
    function owner() external view returns (address);

    function transferOwnership(address newOwner) external;
}

abstract contract Ownable is IOwnable {
    error NotOwner();

    address private _owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    /**
     * @notice Modifier that checks that an account is the owner.
     */
    modifier onlyOwner() {
        if (msg.sender != _owner) revert NotOwner();
        _;
    }

    constructor(address owner_) {
        _owner = owner_;
        emit OwnershipTransferred(address(0), _owner);
    }

    /**
     * @notice Returns the address of the owner.
     */
    function owner() public view virtual returns (address) {
        return _owner;
    }

    /**
     * @notice Transfers ownership to the specified account.
     * @param newOwner The address of the new owner.
     */
    function transferOwnership(address newOwner) public virtual onlyOwner {
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}
