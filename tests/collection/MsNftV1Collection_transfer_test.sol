// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.7.22 <0.9.0;

import "remix_tests.sol"; 
import "remix_accounts.sol";
import "../../contracts/erc721/MsNftV1Collection.sol";

contract testSuite {

    address owner = address(this);

    function transfer_success_test_transferable_true() public {
        MsNftV1Collection collection = new MsNftV1Collection(owner,"","");
        address to = TestsAccounts.getAccount(1);

        collection.mint(owner, "metadata_url");
        collection.setTransferable(0, true);
        collection.approve(to, 0);
        collection.transferFrom(owner, to, 0);
        
        Assert.equal(collection.getTransferable(0), true , "Token should be transferable.");
        Assert.equal(collection.ownerOf(0), to, "New owner of the token should be the recipient.");
    }
  
    function transfer_failure_test_transferable_false() public {
        MsNftV1Collection collection = new MsNftV1Collection(owner,"","");
        address to = TestsAccounts.getAccount(1);

        collection.mint(owner, "metadata_url");
        collection.approve(to, 0);
        
        try collection.transferFrom(owner, to, 0) {
          Assert.ok(false, "Transfer should fail when the token is not transferable.");
        }
        catch {
            Assert.ok(true, "Transfer failed as expected for non-transferable token.");
        }
        Assert.equal(collection.getTransferable(0), false , "Token should still be non-transferable.");
        Assert.equal(collection.ownerOf(0), owner, "Owner of the token should still be the original owner.");
    }
}
    