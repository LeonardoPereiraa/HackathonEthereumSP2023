// SPDX-License-Identifier: MIT
pragma solidity ^0.8.9;

import "@openzeppelin/contracts/token/ERC1155/ERC1155.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract AnimalDonation is ERC1155, Ownable {
    mapping(uint256 => string) public hashOfDoc;   
    mapping(uint256 => address) public TokenCreator;
    mapping(uint256 => uint256) public tokenPrice;
    mapping(uint256 => uint256) public tokenTotal;
    address[] public institutions;
    mapping(address => bool) public isAuthorized;
    uint256 public count ;
    constructor() ERC1155("AnimalDonation") {        
    
    }


    modifier OwnerOfToken(uint256 id){
        require(msg.sender == TokenCreator[id]);
        _;
    }
     modifier Ownable(address _owner){
        require(isAuthorized[_owner]);
        _;
    }
    function addInList(address _institution)public onlyOwner{
        institutions.push(_institution);
        isAuthorized[_institution] = true;
    }
    function setURI(string memory newuri) public onlyOwner {
        _setURI(newuri);
    }

    function uri(uint256 id) public view override virtual  returns (string memory) {
        return hashOfDoc[id];
    }    

    function mint(  uint256 amount,uint256 price, string memory hash)
        Ownable(msg.sender)
        public
    {
        tokenPrice[count] += price;
        createhashOfDoc(count, hash);
        TokenCreator[count] = msg.sender;
        _mint(msg.sender, count, amount,"");
        tokenTotal[count] +=  amount;
        count++;
        
    }  
     function createhashOfDoc(uint256 id, string memory hash) internal {
        hashOfDoc[id] = hash;
    }

     function burn( address account, uint256 id, uint256 amount) public onlyOwner{
        _burn( account,  id,  amount);
    }
     function safeTransferFrom(
        address from,
        address to,
        uint256 id,
        uint256 amount,
        bytes memory data
    ) public virtual override  {
        _safeTransferFrom(from,to,id,amount,"");
    }





    function mintBatch(address to, uint256[] memory ids, uint256[] memory amounts, bytes memory data)
        public
        onlyOwner
    {
        _mintBatch(to, ids, amounts, data);
    }
}