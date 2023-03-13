~~~
TeamName: DifiPwny
ChallengeName: Safe NFT
DeployFunds: 0
Creation: 2022-12-20
Difficulty: 3

ChallengeName: Vending Machine
DeployFunds: 1 gwei
Creation: 2022-07-24
Difficulty: 3

ChallengeName: AAAA
DeployFunds: BBBB
Creation: 2023-02-DD
Difficulty: EEEE
~~~

# SafeNFT
"Often something that appears safe isn't safe at all." 
OBJECTIVE: Claim 2 NFTs for the price of one.
```
// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

import "@openzeppelin/contracts/token/ERC721/extensions/ERC721Enumerable.sol";

contract SafeNFT is ERC721Enumerable {
    uint256 price;
    mapping(address => bool) public canClaim;
    address public owner;

    constructor(address _player) 
        ERC721("Safe Token", "SNFT") {
        price = 1 gwei;

        owner = _player;
    }

    function buyNFT() external payable {
        require(price == msg.value, "INVALID_VALUE");
        canClaim[msg.sender] = true;
    }

    function claim() external {
        require(canClaim[msg.sender], "CANT_MINT");
        _safeMint(msg.sender, totalSupply());
        canClaim[msg.sender] = false;
    }

    function withdraw() public {
        require(msg.sender == owner);
        payable(msg.sender).transfer(address(this).balance);
    }

    function completed() public view returns (bool) {
        return balanceOf(owner) == 2;
    }
}
```

# Vending Machine

For this challenge, you have to deal only with a single Smart Contract called VendingMachine, a simple contract that models after a vending machine that provides only peanuts
At deployment time the contract is funded with some ether and your goal is to drain it from the whole balance.
#### HINT: Focus on the withdrawal function :)
   
```
// SPDX-License-Identifier: MIT
pragma solidity >=0.7.0 <0.9.0;

contract VendingMachine {
    address public owner;
    uint256 private reserve;
    bool private txCheckLock;
    mapping(address => uint256) public peanuts;
    mapping(address => uint256) public consumersDeposit;

    constructor(address player) payable {
        require(
            msg.value >= 1 gwei,
            "You need a minimum of reserve of 1 gwei before deploying the contract"
        );

        owner = player;
        reserve = msg.value;
        peanuts[address(this)] = 2000;
        txCheckLock = false;
    }

    function isExtContract(address _addr) private view returns (bool) {
        uint32 _codeSize;

        assembly {
            _codeSize := extcodesize(_addr)
        }
        return (_codeSize > 0 || _addr != tx.origin);
    }


    modifier isStillValid() {
        require(!txCheckLock, "Sorry, this product project has been hacked");
        _;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "Ownable: caller is not the owner");
        _;
    }

    function getPeanutsBalance() public view returns (uint256) {
        return peanuts[address(this)];
    }

    function getMyBalance() public view returns (uint256) {
        return consumersDeposit[msg.sender];
    }

    function getContractBalance() public view returns (uint256) {
        return address(this).balance;
    }

    function getReserveAmount() public view onlyOwner returns (uint256) {
        return reserve;
    }

    function deposit() public payable isStillValid {
        require(
            msg.value >= 0.1 gwei,
            "You must have at least 0.1 gwei to initiate transaction"
        );
        consumersDeposit[msg.sender] += msg.value;
    }

    function getPeanuts(uint256 units) public isStillValid {
        require(
            consumersDeposit[msg.sender] >= units * 0.1 gwei,
            "You must pay at least 0.1 gwei per peanutToken"
        );
        require(
            peanuts[address(this)] >= units,
            "Not enough peanuts to fulfill the purchase request"
        );

        consumersDeposit[msg.sender] -= units * 0.1 gwei; // Debits caller's deposit
        peanuts[address(this)] -= units; // Reduce the amount purchased from the peanuts stock
        peanuts[msg.sender] += units; //  Credits the caller with amount of peanuts purchased
    }

    function withdrawal() public isStillValid {
        uint256 contractBalanceBeforeTX = getContractBalance();
        uint256 balance = consumersDeposit[msg.sender];
        uint256 finalContractBalance = contractBalanceBeforeTX - balance;

        require(balance > 0, "Insufficient balance");

        (bool sent, ) = msg.sender.call{value: balance}("");
        require(sent, "Failed to send ether");

        consumersDeposit[msg.sender] = 0;

        uint256 contractBalanceAfterTX = getContractBalance();

        if (
            (contractBalanceAfterTX < finalContractBalance) &&
            isExtContract(msg.sender)
        ) {
            txCheckLock = true;
        }
    }

    function restockPeanuts(uint256 _restockAmount) public onlyOwner {
        peanuts[address(this)] += _restockAmount;
    }

    function hasNotBeenHacked() public view onlyOwner returns (bool) {
        return !txCheckLock;
    }
}
```
