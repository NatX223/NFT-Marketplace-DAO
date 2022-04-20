// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

contract Parameters {

    /// royalty percentage
    uint royalty_percentage = 5;

    /// fee percentage
    uint fee_percentage = 1;

    /// budget percentages
    uint engineering_percentage = 20;
    uint marketing_percentage = 20;
    uint maintenance_percentage = 20;

    /// functions to change the parameters

    /// function to change the royalty percent
    function change_royaltyper(uint percentage) public returns (bool success) {
        royalty_percentage = percentage;
        return success;
    }

    /// function to change the fee percent
    function change_feeper(uint percentage) public returns (bool success) {
        fee_percentage = percentage;
        return success;
    }

    /// function to change the engineering percent
    function change_engper(uint percentage) public returns (bool success) {
        engineering_percentage = percentage;
        return success;
    }

    /// function to change the marketing percent
    function change_marper(uint percentage) public returns (bool success) {
        marketing_percentage = percentage;
        return success;
    }

    /// function to change the maintenance percent
    function change_mainper(uint percentage) public returns (bool success) {
        maintenance_percentage = percentage;
        return success;
    }

}