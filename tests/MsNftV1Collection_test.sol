// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.7.22 <0.9.0;

import "remix_tests.sol"; 
import "remix_accounts.sol";
import "../contracts/erc721/MsNftV1Collection.sol";

contract testSuite {

    function mint_success_test() public {
        MsNftV1Collection collection = new MsNftV1Collection(address(this),"","");
        address user = TestsAccounts.getAccount(0);
        collection.mint(TestsAccounts.getAccount(0), "metadata_url");
        
        Assert.equal(collection.ownerOf(0), user , "");
        Assert.equal(collection.balanceOf(user), 1 , "");
        Assert.equal(collection.tokenURI(0), "metadata_url", "");
    }

  
}
    