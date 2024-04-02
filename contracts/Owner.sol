// SPDX-License-Identifier: MIT
pragma solidity ^0.8.18;

import {Ownable} from "./Ownable.sol";

contract Owner is Ownable {
    bool public _execution;

    constructor() Ownable(msg.sender) {}

    function execution() external onlyOwner {
        _execution = true;
    }
}
