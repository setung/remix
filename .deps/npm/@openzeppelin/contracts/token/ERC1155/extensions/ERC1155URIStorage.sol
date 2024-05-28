// SPDX-License-Identifier: MIT
// OpenZeppelin Contracts (last updated v5.0.0) (token/ERC1155/extensions/ERC1155URIStorage.sol)

pragma solidity ^0.8.20;

import {Strings} from "../../../utils/Strings.sol";
import {ERC1155} from "../ERC1155.sol";

abstract contract ERC1155URIStorage is ERC1155 {
    using Strings for uint256;

    uint256 private _tokenId = 0;
    string private _name;
    string private _symbol;
    string private _baseURI = "";
    mapping(uint256 tokenId => string) private _tokenUris;

    constructor(string memory NftName, string memory NftSymbol) {
        _name = NftName;
        _symbol = NftSymbol;
    }

    function _batchMint(address to, string memory _tokenURI, uint256 value) internal {
        uint256 newItemId = _tokenId++;
        _mint(to, newItemId, value, "");
        _setURI(newItemId, _tokenURI);

    }

    function _uniqueMint(address to, string memory _tokenURI, uint256 value) internal {
       for(uint256 i = 0; i < value; i++) {
            uint256 newItemId = _tokenId++;
            _mint(to, newItemId, 1, "");
            _setURI(newItemId, _tokenURI);
       }
    }

    function uri(uint256 tokenId) public view virtual override returns (string memory) {
        string memory tokenUri = _tokenUris[tokenId];
        return bytes(tokenUri).length > 0 ? string.concat(_baseURI, tokenUri) : super.uri(tokenId);
    }

    function _setURI(uint256 tokenId, string memory tokenUri) internal virtual {
        _tokenUris[tokenId] = tokenUri;
        emit URI(uri(tokenId), tokenId);
    }

    function _setBaseURI(string memory baseURI) internal virtual {
        _baseURI = baseURI;
    }

    function tokenURI(uint256 tokenId) public view virtual returns (string memory) {
        return _tokenUris[tokenId];
    }

    function name() public view returns(string memory) {
        return _name;
    }

    function symbol() public view returns(string memory) {
        return _symbol;
    }

}
