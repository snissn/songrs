
pragma solidity ^0.4.0;
contract Users {
    
    struct User {
        string ipfs;
        bytes32 name;   // short name (up to 32 bytes)
    }

    mapping(address => User) public users;
    mapping(bytes32 => bool) public reserved_names;


    function set(bytes32 username, string ipfs) {
        
        users[msg.sender] = User({ipfs:ipfs, name:username});
    }

    function get_ipfs(bytes32 name ) constant returns ( string) {
        return users[msg.sender].ipfs;
    }
}
