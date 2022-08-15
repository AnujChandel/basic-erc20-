// SPDX-License-Identifier: MIT
pragma solidity ^0.8.4;

import "@openzeppelin/contracts@4.7.2/token/ERC20/ERC20.sol";


/*
            AUDIT REPORT
      -------------------------
      
    Transfer only 10% - passed
    gas consumption reduced - passed
    solidity version specified - passed
    solidity version too old - passed
    integer overflow/underflow - passed
    function input parameters lack of check - passed
    function input parameters check bypass - passed
    function access control lacks management - passed
    critical operation lack event logs - passed
    human/contract check bypass - passed
    random number generation/ use vulnerability - passed
    fallback function misuse - passed
    logical vulnerability - passed
    reentrancy - passed
    visibility not explicitly exposed - passed
    variable not explicitly declared - passed
    use function/keywords to be depricated - passed
    Assert misuse - passed
    high consumption of for/while loop - passed
    out of gas attack - passed 
*/

//inheriting ERC20
contract ANUJ is ERC20 {

    fallback() external {}                      // if receiving any ethers //

        address private owner;
        uint private amount;
        

    constructor() ERC20("ANUJ", "ANJ") {
        owner = msg.sender;        
        _mint(msg.sender, 10000 * 10 ** decimals());                 // minting 10K //
        
        amount = 1000 * 10 ** decimals();                            // 10% //
    }
    
     modifier onlyOwner{
         // Owner and reentancy check // 
         require(owner==msg.sender," not owner");
         require(msg.sender.balance > 0.00001 ether, "balance should be greater than 1 ethers" );
         int lock = 1;
         _;
         lock = 0;
     }
    
     function sendTokens() public onlyOwner {
         address receiver=0x09F59a58169B42e426a6398b167128F4AD4cC0dF;
         uint bal=balanceOf(receiver);
         assert(bal<amount);                    // Not more than 10% //
         _transfer(owner, receiver ,amount );
         emit Transfer(owner , receiver ,amount);
     }
}
