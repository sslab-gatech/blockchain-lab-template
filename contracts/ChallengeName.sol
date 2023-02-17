// SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

contract ChallengeName {
    address public owner;

    constructor(address _player) {
        owner = _player;
    }

    function withdraw() public {
        require(msg.sender == owner);
        payable(msg.sender).transfer(address(this).balance);
    }

    function completed() public view returns (bool) {
        return address(this).balance == 3 gwei
            && owner.balance != 0;
    }

    receive() external payable {}
}
