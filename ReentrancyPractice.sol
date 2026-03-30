function withdraw() public {
    // 1. CHECK
    uint256 amount = balances[msg.sender];
    require(amount > 0, "Insufficient balance");

    // 2. EFFECT (Update the balance FIRST)
    balances[msg.sender] = 0; 

    // 3. INTERACTION (Send the money LAST)
    (bool success, ) = msg.sender.call{value: amount}("");
    require(success, "Transfer failed");
}

