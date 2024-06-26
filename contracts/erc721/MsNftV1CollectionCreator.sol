// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/access/Ownable.sol";
import "./MsNftV1Collection.sol";

contract NftV1CollectionCreator is Ownable{

    event DeployContract(address from, address contractAddress);
    
    constructor() Ownable(msg.sender){} 
 
    function deployContract(string memory name, string memory symbol) external onlyOwner {
        address contractAddress = address(new MsNftV1Collection(msg.sender, name, symbol));
        emit DeployContract(msg.sender, contractAddress);
    }
    
}
