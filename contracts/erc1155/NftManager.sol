// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "./NftV1Collection.sol";

contract NftManager {

    function allMint(address[] memory contractAddr) public {
          for(uint i = 0; i < contractAddr.length; i++) {
            NftV1Collection collection = NftV1Collection(contractAddr[i]);
            collection.uniqueMint(msg.sender,"",1);
        }
    }
}