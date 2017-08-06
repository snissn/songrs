pragma solidity ^0.4.0;

contract Song{
  string ipfs;
  string name;
  address artist;
  address album;
}

contract Album {
  string ipfs;
  string name;
  string name;
  address[] songs;
}
contract Users {
    
    
    struct User {
        string ipfs;
        bytes32 name;   // short name (up to 32 bytes)
    }

    mapping(address => User) public users;
    mapping(bytes32 => bool) public reserved_names;
    mapping(address => Song) public songs_mapping;
    Song[]  songs;
 
 

    function set(bytes32 username, string ipfs) {
       
       users[msg.sender] = User({ipfs:ipfs, name:username});
    }
    
    function create_song(string ipfs, string name){
        songs.push(Song({ipfs:ipfs, name:name}));
    }

    function get_ipfs(bytes32 name ) constant returns ( string) {
        return users[msg.sender].ipfs;
    }
}



