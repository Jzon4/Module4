// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract DegenToken is ERC20, Ownable {
  event TokensMinted(address indexed receiver, uint amount);
  enum SellItem {
    DEGEN_CURTAIN,
    DEGEN_CABINET,
    DEGEN_CHAIR
  }
  mapping(SellItem => uint) public AlejandroShopPrices;

  constructor() ERC20("Alejandro", "ALJDRO") Ownable(msg.sender) {
    _mint(msg.sender, 20000 * 20**decimals());

    AlejandroShopPrices[SellItem.DEGEN_CURTAIN] = 400;
    AlejandroShopPrices[SellItem.DEGEN_CURTAIN] = 6000;
    AlejandroShopPrices[SellItem.DEGEN_CHAIR] = 1000;
  }

  function mint(address _seller, uint _amount) public onlyOwner {
    _mint(_seller, _amount);
    emit TokensMinted(_seller, _amount);
  }

  function alejandroTokens(address _seller, uint _amount) public {
    _transfer(msg.sender, _seller, _amount);
  }

  function redeemTokens(SellItem _item) public {
    uint256 itemPrice = AlejandroShopPrices[_item];
    require(balanceOf(msg.sender) >= itemPrice, "You have insufficient balance, try again");

    _burn(msg.sender, itemPrice);
  }

  function degenTokenBalance(address _buyer) public view returns (uint) {
    return balanceOf(_buyer);
  }

  function burnTokens(uint _amount) public {
    require(balanceOf(msg.sender) >= _amount, "You have insufficient balance, try again");
    _burn(msg.sender, _amount);
  }
}
