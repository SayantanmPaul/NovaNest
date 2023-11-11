// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.9;

contract NestCrowdFunding {
    struct Campagin{
        address userOwner;
        string title;
        string description;
        uint256 targetAmmount;
        uint256 deadlineProject;
        uint256 amaountAchived;
        string images;
        address[] contributors;
        uint256[] donations;

    }
    mapping (uint256=> Campagin) public campagins;

    //keeping track num of contributors
    uint256 public numOfCampagins=0;

    function createCampagin(){

    }
    function contributeCampagin(){

    }
    function getContributors(){

    }
    function listGetCampagins(){

    }
}