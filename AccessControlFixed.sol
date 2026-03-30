// SPDX-License-Identifier: MIT
pragma solidity ^0.8.0;

/**
 * @title AccessControlPractice
 * @dev Demonstrates the use of modifiers to restrict function access.
 */
contract AccessControlPractice {
    address public owner;

    // The constructor sets the deployer as the initial owner
    constructor() {
        owner = msg.sender;
    }

    // --- SECURITY MODIFIER ---
    // This acts as a guard for sensitive functions
    modifier onlyOwner() {
        require(msg.sender == owner, "Error: Caller is not the owner");
        _; // This symbol tells Solidity to continue to the function body
    }

    /**
     * @dev Allows the current owner to transfer control of the contract to a newOwner.
     * @param _newOwner The address to transfer ownership to.
     */
    function changeOwner(address _newOwner) public onlyOwner {
        require(_newOwner != address(0), "New owner is the zero address");
        owner = _newOwner;
    }

    /**
     * @dev A sensitive function that only the owner should be able to call.
     */
    function withdrawAll() public onlyOwner {
        uint256 balance = address(this).balance;
        require(balance > 0, "No ETH to withdraw");
        
        (bool success, ) = payable(owner).call{value: balance}("");
        require(success, "Transfer failed");
    }

    // Allow the contract to receive ETH so we can test withdrawal
    receive() external payable {}
}
