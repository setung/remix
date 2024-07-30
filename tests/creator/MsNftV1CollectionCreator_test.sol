// SPDX-License-Identifier: GPL-3.0
        
pragma solidity >=0.7.0 <0.9.0;

import "remix_tests.sol"; 
import "remix_accounts.sol";
import "../../contracts/erc721/MsNftV1CollectionCreator.sol";
import "../../contracts/erc721/MsNftV1Collection.sol";

contract testSuite {

    function deploy_collection_success_test() public {
      MsNftV1CollectionCreator creator = new MsNftV1CollectionCreator();
      string memory name = "MyToken";
      string memory symbol = "MTK";

      MsNftV1Collection collection =  MsNftV1Collection(creator.deployContract(name, symbol));
      
      Assert.equal(collection.name(), name, "name");
      Assert.equal(collection.symbol(), symbol, "symbol");
    }

    function deploy_collection_failure_test_not_owner() public {
      MsNftV1CollectionCreator creator = new MsNftV1CollectionCreator();
      creator.transferOwnership(msg.sender);

      try creator.deployContract("name", "symbol") {
          Assert.ok(false,"");
      }
      catch {
          Assert.ok(true,"");
      }
    }
    
}
    