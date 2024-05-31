// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
    event TokensMinted(address indexed receiver, uint amount);
    event ItemRedeemed(address indexed buyer, SellItem item);

    enum SellItem {
        DEGEN_CURTAIN,
        DEGEN_CABINET,
        DEGEN_CHAIR
    }

    mapping(SellItem => uint) public AlejandroShopPrices;
    mapping(address => uint) public redeemedItems;

    constructor() ERC20("Alejandro", "ALJDRO") Ownable(msg.sender) {
        _mint(msg.sender, 20000 * 10**decimals());

        AlejandroShopPrices[SellItem.DEGEN_CURTAIN] = 400;
        AlejandroShopPrices[SellItem.DEGEN_CABINET] = 6000;
        AlejandroShopPrices[SellItem.DEGEN_CHAIR] = 1000;
    }

    function mint(address _seller, uint _amount) public onlyOwner {
        _mint(_seller, _amount);
        emit TokensM
