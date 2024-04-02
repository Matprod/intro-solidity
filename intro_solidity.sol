// SPDX-License-Identifier: MIT

pragma solidity >=0.8.18;


contract Storage {

    uint256 number;
    mapping(address => uint256) AddressToValue;
    address public immutable i_owner;
    uint256 value;


    constructor()
    {
        i_owner = msg.sender;
    }
    
    modifier onlyOwner() {
        require(msg.sender == i_owner, "Not owner");

        _;
    }
    function store(uint256 num) public {
        number = num;
    }

    function retrieve() public view returns (uint256){
        return number;
    }
    function getBalance() public view returns (uint256) {
        return address(this).balance;
    }



    function send() public payable {
        value += msg.value;
    }

    function withdraw() public onlyOwner{
        // Call returns a boolean value indicating success or failure.
        // This is the current recommended method to use.
        (bool callSuccess,) = payable(msg.sender).call{value: address(this).balance}("");
        require(callSuccess, "Call Failed") ;
    }

    function fibo(uint256 n) public pure returns (uint256)
    {
        uint256 a = 0;
        uint256 b = 1;
        uint256 i = 0;
        uint256 sum;

        if (n == 0)
            return 0;
        else if (n == 1)
            return 1;
        else
        {
            while(i++ < n-1)
            {
                sum = a + b;
                a = b;
                b = sum;
            }
            return sum;
        }
    }
    receive() external payable {}
    fallback() external payable {}

    
}       
