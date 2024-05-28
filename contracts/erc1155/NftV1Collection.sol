// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

import "@openzeppelin/contracts/token/ERC1155/extensions/ERC1155URIStorage.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract NftV1Collection is ERC1155URIStorage, Ownable {

    event Mint(address[] to);

    constructor(address initialOwner, string memory name, string memory symbol) ERC1155URIStorage(name, symbol) Ownable(initialOwner) {
    }

    function uniqueMint(address to, string memory _tokenURI, uint256 value) external onlyOwner {
       _uniqueMint(to, _tokenURI, value);

        address[] memory toArray = new address[](1);
        toArray[0] = to;
        emit Mint(toArray);
    }

    function uniqueMint(address[] memory to, string memory _tokenURI) external onlyOwner {
       for(uint256 i = 0; i < to.length; i++) {
            _uniqueMint(to[i], _tokenURI, 1);
       }
       
       emit Mint(to);
    }

     function uniqueMint(address[] memory to, string[] memory _tokenURI) external onlyOwner {
       for(uint256 i = 0; i < to.length; i++) {
            _uniqueMint(to[i], _tokenURI[i], 1);
       }

       emit Mint(to);
    }

    function upgrade(address to, uint256 tokenId, string memory _tokenURI) external onlyOwner {
        
    }

    function burn(address account, uint256 id, uint256 value) external  virtual onlyOwner{
      /**
        if (account != _msgSender() && !isApprovedForAll(account, _msgSender())) {
            revert ERC1155MissingApprovalForAll(_msgSender(), account);
        }
       **/
        _burn(account, id, value);
    }

    function burnBatch(address account, uint256[] memory ids, uint256[] memory values) external onlyOwner {
       /**
        if (account != _msgSender() && !isApprovedForAll(account, _msgSender())) {
            revert ERC1155MissingApprovalForAll(_msgSender(), account);
        }
        **/
        _burnBatch(account, ids, values);
    }

    function setURI(uint256 tokenId, string memory tokenUri) external onlyOwner {
        _setURI(tokenId, tokenUri);
    }
}