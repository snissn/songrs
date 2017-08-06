pragma solidity ^0.4.14;

contract Song{
    
    string ipfs;
    string name;
    function Song(string _ipfs, string _name){
        ipfs = _ipfs;
        name = _name;
    
    }
}
contract Artists {
    
    
    struct Artist {
        string ipfs;
        bytes32 name;   // short name (up to 32 bytes)
        address[] albums;
        address[] singles;
    }

    mapping(address => Artist) public artists;
    mapping(bytes32 => bool) public reserved_names;

    function set(bytes32 username, string ipfs) {
       address[] storage albums;
       address[] storage singles;
       artists[msg.sender] = Artist({ipfs:ipfs, name:username, albums:albums,singles:singles});
       reserved_names[username] = true;
    }
    
    function create_single(string ipfs, string name){
        //songs_mapping[msg.sender].push(Song({ipfs:ipfs, name:name}));
        address s = address(new Song(ipfs,name));
        artists[msg.sender].singles.push(s);
        
    }

    function get_ipfs(bytes32 name ) constant returns ( string) {
        return artists[msg.sender].ipfs;
    }
}
