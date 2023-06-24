// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;
import "./nft1155.sol";
contract Operations {
    address public tokenContract;
    constructor(address _tokenContract ) {
            tokenContract = _tokenContract;   
    }

    function BuyToken(uint256 id, address payable _to)public payable{
        require(msg.value >= AnimalDonation(tokenContract).tokenPrice(id));
        uint256 numberToken = msg.value / AnimalDonation(tokenContract).tokenPrice(id);
        bool sent = _to.send(msg.value);
        require(sent, "Failed to send Ether");
        AnimalDonation(tokenContract).safeTransferFrom( AnimalDonation(tokenContract).TokenCreator(id),msg.sender,id,numberToken,"");

    }
}