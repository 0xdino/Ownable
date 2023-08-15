// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import "./Ownable.sol";

contract Example is Ownable {
    bool public _execution;

    constructor() {}

    function execution() external onlyOwner {
        _execution = true;
    }
}
