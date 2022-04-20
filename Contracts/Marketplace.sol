// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

import "./User.sol";

contract Marketplace {

    User public user;

    /// the events to be emitted
    event NFTlisted(address sender);
    event NFTbought(address sender);

    /// dummy function to list NFT
    function list_NFT() public returns (bool success) {
        user.update_listedNFTs(msg.sender);
        emit NFTlisted(msg.sender);
        return success;
    }

    /// dummy function to buy NFT
    function buy_NFT() public returns (bool success) {
        user.update_boughtNFTs(msg.sender);
        emit NFTbought(msg.sender);
        return success;
    }

}