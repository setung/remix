// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.7.22 <0.9.0;

import "remix_tests.sol"; 
import "remix_accounts.sol";
import "../../contracts/erc721/MsNftV1Collection.sol";


contract testSuite {

    address owner = address(this);

    function exchange_new_token_success_test() public {
        MsNftV1Collection collection = new MsNftV1Collection(owner, "", "");
        collection.mint(owner, "metadata_url");
        collection.exchangeNewToken(owner, 0, "exchanged_url");

        Assert.equal(collection.ownerOf(1), owner , "Owner of the minted token should be the user.");
        Assert.equal(collection.balanceOf(owner), 1 , "User should have a balance of 1 NFT.");
        Assert.equal(collection.tokenURI(1), "exchanged_url", "Token URI should be 'exchanged_url'.");
        Assert.equal(collection.getTransferable(0), false, "Newly minted token should not be transferable.");
        try collection.ownerOf(0) {
          Assert.ok(false,"");
        }
        catch {
          Assert.ok(true,"");
        }
    }

    function exchange_new_token_failure_test_not_owner() public {
        MsNftV1Collection collection = new MsNftV1Collection(owner, "", "");
        collection.mint(owner, "metadata_url");
        collection.transferOwnership(TestsAccounts.getAccount(0));
        
        try collection.exchangeNewToken(owner, 0, "exchanged_url") {
            Assert.ok(false, "Mint should fail when called by non-owner.");
        }
        catch {
            Assert.ok(true, "Mint failed as expected when called by non-owner.");
        }
        Assert.equal(collection.ownerOf(0), owner , "Owner of the minted token should be the user.");
    }

    function exchange_new_token_failure_test_not_token_owner() public {
        MsNftV1Collection collection = new MsNftV1Collection(owner, "", "");
        collection.mint(owner, "metadata_url");
        
        try collection.exchangeNewToken(TestsAccounts.getAccount(0), 0, "exchanged_url") {
            Assert.ok(false, "Exchange should fail when called by non-owner.");
        }
        catch {
            Assert.ok(true, "Exchange failed as expected when called by non-owner.");
        }
        Assert.equal(collection.ownerOf(0), owner , "Owner of the minted token should be the user.");
    }

}
    