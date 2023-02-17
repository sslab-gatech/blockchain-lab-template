========================================
TeamName: AAAA
ChallengeName: BBBB
DeployFunds: CCCC
Creation: 2023-02-DD
Difficulty: EEEE
========================================

1. Update the metadata above (AAAA-EEEE). Note: CCCC = 0 if you don't need any initial
   fund, otherwise, specify in wei.

2. Check what's in the repo:

  ├── contracts
  │   ├── ChallengeName.sol         # FFFF. main challenge
  │   ├── ChallengeNameFactory.sol  # GGGG. factory to deploy and check the challenge
  │   └── Level.sol                 # interface. don't touch
  ├── scripts
  │   ├── deploy.py                 # HHHH. for deployment to the chain
  │   ├── exploit.py                # IIII. your solution and script to check if it's working
  │   └── pwn.py                    # utils. don't touch
  ├── README.md                     # JJJJ. this file!
  
3. If you run scripts/exploit.py, it deploys the challenge and checks if it's working.

~~~{.sh}
  $ brownie run scripts/exploit.py
  Brownie v1.19.2 - Python development framework for Ethereum
  
  BlockchainLabTemplateProject is the active project.
  
  Launching 'ganache-cli --chain.vmErrorsOnRPCResponse true ...' ...
  
  Running 'scripts/exploit.py::main'...
  Transaction sent: 0xb20f4e89842b4fd3e55ba4125d2585ea5f255eec6713ab05a4cfee546749365d
    Gas price: 0.0 gwei   Gas limit: 12000000   Nonce: 0
    ChallengeNameFactory.constructor confirmed   Block: 1   Gas used: 276723 (2.31%)
    ChallengeNameFactory deployed at: 0xe7CB1c67752cBb975a56815Af242ce2Ce63d3113
  
  Transaction sent: 0x32cc8dfd4d521cf6076a951118a4545490d4afc33b7c4d3265d530df0707033b
    Gas price: 0.0 gwei   Gas limit: 12000000   Nonce: 1
    ChallengeNameFactory.createInstance confirmed   Block: 2   Gas used: 145171 (1.21%)
  
  player  : 0x66aB6D9362d4F35596279692F0251Db635165871
  factory : 0xe7CB1c67752cBb975a56815Af242ce2Ce63d3113
  instance: 0x90d1ec7E45556577d8C68a77A7E1d2813BAb6C56
  Transaction sent: 0x8897b4b71023b61cf6c82ec94fb72d633f15f26de47e87200a6e7aa5aa947c0a
    Gas price: 0.0 gwei   Gas limit: 12000000   Nonce: 0
    Transaction confirmed   Block: 3   Gas used: 21055 (0.18%)

*
* [!] Solved
*

  Terminating local RPC client...
~~~

4. "ChallengeName" -> a unique challenge name (FFFF, GGGG, HHHH, IIII, JJJJ). And see
   if it's still working.

5. Design your challenge and a way to deploy (FFFF, GGGG)!
6. Add your solution to (IIII)
6. Describe your challenge in README.md below!

========================================
ChallengeName
========================================

How can you send 3 gwei to a smart contract? One via MetaMask, one via geth, and
one via web3.js.

# NOTE. this will release the code (ChallengeName.sol)!
<CODE>
