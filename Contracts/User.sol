// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract User {

    /// mapping a user to the number of NFTs listed
    mapping(address => uint) public ListedNFTs;

    /// mapping a user to the number of NFTs bought
    mapping(address => uint) public BoughtNFTs;

    /// function to update the users listed NFTs
    function update_listedNFTs(address sender) public returns (bool success) {
        ListedNFTs[sender] = ListedNFTs[sender] + 1;
        return success;
    }

    /// function to update the users bought NFTs
    function update_boughtNFTs(address sender) public returns (bool success) {
        BoughtNFTs[sender] = BoughtNFTs[sender] + 1;
        return success;
    }

}