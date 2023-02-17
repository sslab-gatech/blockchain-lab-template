// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import "./ChallengeName.sol";
import "./Level.sol";

contract ChallengeNameFactory is Level {
    function createInstance(address _player) override public payable returns (address) {
        ChallengeName level = new ChallengeName(_player);
        return address(level);
    }

    function validateInstance(address payable _instance, address _player) override public returns (bool) {
        ChallengeName level = ChallengeName(_instance);
        return level.completed();
    }
}
