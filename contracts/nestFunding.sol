// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract NestCrowdFunding {
    struct Campagin {
        address userOwner;
        string title;
        string description;
        uint256 target;
        uint256 deadlineProject;
        uint256 amaountAchived;
        string images;
        address[] contributors;
        uint256[] donations;
    }

    mapping(uint256 => Campagin) public campagins;

    //keeping track num of contributors
    uint256 public numOfCampagins = 0;

    //campagin details which is visible to the public
    function createCampagin(
        address _campaginOwner,
        string memory _title,
        string memory _description,
        uint256 _target,
        uint256 _deadline,
        string memory _images
    ) public returns (uint256) {
        Campagin storage campagin = campagins[numOfCampagins];
        //deadline checkpoint
        require(
            campagin.deadlineProject < block.timestamp,
            "the deadline should be a target date for future of minimum 12 hours! "
        );

        campagin.userOwner = _campaginOwner;
        campagin.title = _title;
        campagin.description = _description;
        campagin.target = _target;
        campagin.deadlineProject = _deadline;
        campagin.amaountAchived = 0;
        campagin.images = _images;

        numOfCampagins++;

        return numOfCampagins - 1;
    }

    //contribute campaign function
    function contributeCampagin(uint256 _ID) public payable {
        uint256 amaountValue = msg.value;

        Campagin storage campaign = campagins[_ID];
        campaign.contributors.push(msg.sender);
        campaign.donations.push(amaountValue);

        (bool sent, ) = payable(campaign.userOwner).call{value: amaountValue}(
            ""
        );
        if (sent) {
            campaign.amaountAchived = campaign.amaountAchived + amaountValue;
        }
    }

    //contribution donators transactions
    function getContributors(
        uint256 _userId
    ) public view returns (address[] memory, uint256[] memory) {
        return (campagins[_userId].contributors, campagins[_userId].donations);
    }

    //campeign list update
    function listGetCampagins() public view returns (Campagin[] memory) {
        Campagin[] memory allCampaigns = new Campagin[](numOfCampagins);

        for (uint i = 0; i < numOfCampagins; i++) {
            Campagin storage item = campagins[i];

            allCampaigns[i] = item;
        }

        return allCampaigns;
    }
}
