// SPDX-License-Identifier: GPL-3.0

pragma solidity >=0.7.0 <0.9.0;

// importing the needed contracts
import "./User.sol";
import "./Parameters.sol";

contract Governance {

    // instantiating the needed contracts
    User internal user;
    Parameters internal parameter;

    // creating a proposal struct
    struct Proposal {
        // the title of the proposal
        string title;
        // the description of the proposal
        string description;
        // the parameters that will be affected
        uint parameter;
        // the value of the parameter to be changed
        uint value;
        // the deadline of the proposal
        uint deadline;
        // the votes for the proposal
        uint for_votes;
        // the votes against the proposal
        uint against_votes;
        // the state of the proposal
        bool executed;
        // voters - a mapping of addresses to booleans indicating whether address has cast a vote or not
        mapping (address => bool) voters;
    }

    // Create a mapping of ID to Proposal
    mapping(uint256 => Proposal) public proposals;
    // Number of proposals that have been created
    uint256 public numProposals;

    // Create a modifier which only allows a function to be
    // called by someone who has listed at least 10 NFTs and bought atleast 5 NFTs
    modifier memberOnly() {
        require(user.bought(msg.sender) > 5, "USER HAS NOT BOUGHT ENOUGH NFTS");
        require(user.listed(msg.sender) > 10, "USER HAS NOT LISTED ENOUGH NFTS");
        _;
    }

    function create_proposal(string memory title, string memory description, uint parameter, uint value, uint duration) public memberOnly returns (uint) {
        uint id = numProposals++;
        Proposal storage proposal = proposals[id];
        proposal.title = title;
        proposal.parameter = parameter;
        proposal.value = value;
        proposal.deadline = block.timestamp + 2 weeks;
        proposal.description = description;

        return id;
    }

    // Create a modifier which only allows a function to be
    // called if the given proposal's deadline has not been exceeded yet
    modifier activeProposalOnly(uint proposalIndex) {
        require(
            proposals[proposalIndex].deadline > block.timestamp,
            "DEADLINE_EXCEEDED"
        );
        _;
    }

    // function to cast vote
    function cast_vote(uint proposalIndex, bool vote) public memberOnly activeProposalOnly(proposalIndex) returns (bool success) {
        Proposal storage proposal = proposals[proposalIndex];
        require(proposal.voters[msg.sender] == false);
        uint votes = user.listed(msg.sender) + user.bought(msg.sender);
        if(vote == true) {
            proposal.for_votes += votes;
        }
        else {
            proposal.against_votes += votes;
        }

        proposal.voters[msg.sender] == true;
        return success;
    }

    // Create a modifier which only allows a function to be
    // called if the given proposals' deadline HAS been exceeded
    // and if the proposal has not yet been executed
    modifier inactiveProposalOnly(uint256 proposalIndex) {
        require(
            proposals[proposalIndex].deadline <= block.timestamp,
            "DEADLINE_NOT_EXCEEDED"
        );
        require(
            proposals[proposalIndex].executed == false,
            "PROPOSAL_ALREADY_EXECUTED"
        );
        _;
    }

    /// @dev executeProposal allows any CryptoDevsNFT holder to execute a proposal after it's deadline has been exceeded
    /// @param proposalIndex - the index of the proposal to execute in the proposals array
    function executeProposal(uint256 proposalIndex)
        public
        memberOnly
        inactiveProposalOnly(proposalIndex) returns (bool)
    {
        Proposal storage proposal = proposals[proposalIndex];

        // If the proposal has more for votes than against votes
        // purchase the NFT from the FakeNFTMarketplace
        if (proposal.for_votes > proposal.against_votes) {
            if (proposal.parameter == 0) {
                parameter.change_royaltyper(proposal.value);
                proposal.executed = true;
            }
            else if (proposal.parameter == 1) {
                parameter.change_feeper(proposal.value);
                proposal.executed = true;
            }
            else if (proposal.parameter == 2) {
                parameter.change_engper(proposal.value);
                proposal.executed = true;
            }
            else if (proposal.parameter == 3) {
                parameter.change_marper(proposal.value);
                proposal.executed = true;
            }
            else if (proposal.parameter == 4) {
                parameter.change_mainper(proposal.value);
                proposal.executed = true;
            }
            return true;
        }
        else { return false; 
        }
    }
}

