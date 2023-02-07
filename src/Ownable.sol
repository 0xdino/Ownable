// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;

abstract contract Ownable {
    error NotOwner();

    address private _owner;

    event OwnershipTransferred(
        address indexed previousOwner,
        address indexed newOwner
    );

    modifier onlyOwner() {
        if (msg.sender != _owner) revert NotOwner();
        _;
    }

    constructor() {
        _owner = msg.sender;
        emit OwnershipTransferred(address(0), _owner);
    }

    function owner() external view virtual returns (address) {
        return _owner;
    }

    function transferOwnership(address newOwner) external virtual onlyOwner {
        emit OwnershipTransferred(_owner, newOwner);
        _owner = newOwner;
    }
}
