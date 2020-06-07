pragma solidity ^0.5.1;

contract CustomerOwnerRelation
{
    // structure of a customer. Has their name, address and balance
    struct _customer
    {
        string _name;
        address _address;
        uint256 _balance;
    }
    
    // define the customer in this contract
    _customer myCustomer;
    
    // wallet of the provider
    address payable wallet;

    // constructor of the contract. Specifies who the provider is
    constructor(string memory _name) public
    {
        myCustomer = _customer(_name, msg.sender, 0);
        wallet = 0xda512e91bc8c761e447C91f2031be4D98A078E08;
    }
    
    // modifier that restricts accounts with no balance to use tokens
    modifier hasTokens()
    {
        require(myCustomer._balance > 0);
        _;
    }
    
    // modifier that only allows the customer to call the function
    modifier onlyCustomer()
    {
        require(msg.sender == myCustomer._address);
        _;
    }
    
    // function that purchases one token and adds it to the balance of the sender. So far, the customer specifies the amount of eth being paid
    function mint() public payable onlyCustomer
    {
        wallet.transfer(msg.value);
        myCustomer._balance ++;
    }
    
    // use the customer's token for a service
    function useToken() public hasTokens onlyCustomer
    {
        // perform service
        myCustomer._balance --;
    }
    
    // get the customer's token balance
    function getBalance() public view returns(uint256)
    {
        return myCustomer._balance;
    }
    
    // get the customer's name
    function getName() public view returns(string memory)
    {
        return myCustomer._name;
    }
}
