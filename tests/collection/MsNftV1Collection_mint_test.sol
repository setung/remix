// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.7.22 <0.9.0;

import "remix_tests.sol"; 
import "remix_accounts.sol";
import "../../contracts/erc721/MsNftV1Collection.sol";

contract testSuite {

    address owner = address(this);

    function mint_success_test() public {
        MsNftV1Collection collection = new MsNftV1Collection(owner, "", "");
        address user = TestsAccounts.getAccount(0);
        collection.mint(TestsAccounts.getAccount(0), "metadata_url");
        
        Assert.equal(collection.ownerOf(0), user , "Owner of the minted token should be the user.");
        Assert.equal(collection.balanceOf(user), 1 , "User should have a balance of 1 NFT.");
        Assert.equal(collection.tokenURI(0), "metadata_url", "Token URI should be 'metadata_url'.");
        Assert.equal(collection.getTransferable(0), false, "Newly minted token should not be transferable.");
    }

    function mint_failure_test_not_owner() public {
        MsNftV1Collection collection = new MsNftV1Collection(owner, "", "");
        collection.transferOwnership(TestsAccounts.getAccount(0));
        
        try collection.mint(TestsAccounts.getAccount(0), "") {
            Assert.ok(false, "Mint should fail when called by non-owner.");
        }
        catch {
            Assert.ok(true, "Mint failed as expected when called by non-owner.");
        }
    }

}
    