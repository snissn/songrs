pragma solidity ^0.4.14;

contract Song{

    string ipfs;
    string name;
    address artist;
    function Song(string _ipfs, string _name, address _artist){
        ipfs = _ipfs;
        name = _name;
        artist = _artist;
    }
}

contract Album{

    Song[]  songs;
    string public name;
    address artist;
    function Album(string _name){
        name = _name;
    }
    function add_song(Song song){
        songs.push(song);
    }
}
contract Artists {

    event NewArtistEvent(bytes32 username, string ipfs);
    event NewSongEvent(bytes32 artist_username, string artist_ipfs, string song_name, string song_ipfs);
    event NewAlbumEvent(bytes32 artist_username, string artist_ipfs, string album_name);


    struct Artist {
        string ipfs;
        bytes32 name;   // short name (up to 32 bytes)
        address[] albums;
        address[] singles;
    }

    mapping(address => Artist) public artists;
    mapping(bytes32 => bool) public reserved_names;

    function create_artist(bytes32 username, string ipfs) {
       address[] storage albums;
       address[] storage singles;
       artists[msg.sender] = Artist({ipfs:ipfs, name:username, albums:albums,singles:singles});
       reserved_names[username] = true;

       NewArtistEvent(username, ipfs);

    }

    function create_album(string name) returns (address){
        address album = address(new Album(name));
        artists[msg.sender].albums.push(album);
        Artist artist = artists[msg.sender];
        NewAlbumEvent(artist.name, artist.ipfs, name);
        return album;
    }


    function add_song_to_album(address album_address, address song_address){
        Album album = Album(album_address);
        Song song = Song(song_address);
        album.add_song(song);
    }

    function create_single(string name, string ipfs)  returns (address){
        //songs_mapping[msg.sender].push(Song({ipfs:ipfs, name:name}));
        address song = address(new Song(ipfs,name, msg.sender));
        artists[msg.sender].singles.push(song);
        Artist artist = artists[msg.sender];
        NewSongEvent(artist.name, artist.ipfs, name, ipfs);
        return song;

    }

    function get_ipfs(bytes32 name ) constant returns ( string) {
        return artists[msg.sender].ipfs;
    }
}

