// SPDX-License-Identifier: Unlicense
pragma solidity 0.8.2;

import "@openzeppelin/contracts-upgradeable/token/ERC20/presets/ERC20PresetFixedSupplyUpgradeable.sol";
import "@openzeppelin/contracts-upgradeable/token/ERC721/presets/ERC721PresetMinterPauserAutoIdUpgradeable.sol";

contract TokenMaker{

    function createToken(string calldata name, string calldata symbol, uint256 initialsupply) external returns (address){
        ERC20PresetFixedSupplyUpgradeable token = new ERC20PresetFixedSupplyUpgradeable();
        token.initialize(name, symbol, initialsupply, msg.sender);
        return address(token);
    }

    function createNFT(string calldata name, string calldata symbol, string calldata baseTokenURI) external returns (address){
        ERC721PresetMinterPauserAutoIdUpgradeable nft = new ERC721PresetMinterPauserAutoIdUpgradeable();
        nft.initialize(name, symbol, baseTokenURI);
        nft.mint(msg.sender);
        return address(nft);
    }

}
