// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.7.22 <0.9.0;

import "remix_tests.sol"; 
import "remix_accounts.sol";
import "../../contracts/erc721/MsNftV1Collection.sol";

contract testSuite {

    address owner = address(this);

    function listing_success_test() public {
        MsNftV1Collection collection = new MsNftV1Collection(owner, "", "");
        collection.mint(owner, "metadata_url");
        collection.listNft(0, 1000);

        Assert.equal(collection.isForSale(0), true, "Token should be listed for sale.");
        Assert.equal(collection.price(0), 1000, "Token price should be set to 1000.");
    }

    function listing_failure_test_not_owner() public {
        MsNftV1Collection collection = new MsNftV1Collection(owner, "", "");
        collection.mint(TestsAccounts.getAccount(1), "metadata_url");

        try collection.listNft(0, 1000) {
            Assert.ok(false, "Listing should fail when the caller is not the token owner.");
        }
        catch {
            Assert.ok(true, "Listing failed as expected when the caller is not the token owner.");
        }
    }
}
    