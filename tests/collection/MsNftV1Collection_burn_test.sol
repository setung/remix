// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.7.22 <0.9.0;

import "remix_tests.sol"; 
import "remix_accounts.sol";
import "../../contracts/erc721/MsNftV1Collection.sol";

contract testSuite {

    address owner = address(this);

    function burn_success_test() public {
        MsNftV1Collection collection = new MsNftV1Collection(owner, "", "");
        collection.mint(owner, "");
        
        collection.burn(0);
        
        try collection.ownerOf(0) {
          Assert.ok(false, "Token owner query should fail for a burned token.");
        }
        catch {
          Assert.ok(true, "Token owner query failed as expected for a burned token.");
        }
        
        Assert.equal(collection.balanceOf(owner), 0, "Owner's balance should be 0 after burning the token.");
    }

    function  burn_failure_test_not_owner() public {
        MsNftV1Collection collection = new MsNftV1Collection(owner, "", "");
        collection.transferOwnership(TestsAccounts.getAccount(0));
        
        try collection.burn(0) {
          Assert.ok(false, "Burn should fail when called by non-owner.");
        }
        catch {
            Assert.ok(true, "Burn failed as expected when called by non-owner.");
        }
    }
}
    