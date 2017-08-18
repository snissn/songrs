pragma solidity ^0.4.14;

//#ujo
//consensys
//truebit
//yondon@livepeer.org

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

    event NewArtistEvent(bytes32 username, string ipfs, address sender);
    event NewSongEvent(bytes32 artist_username, string artist_ipfs, string song_name, string song_ipfs, address sender);
    event NewAlbumEvent(bytes32 artist_username, string artist_ipfs, string album_name, address sender);


    struct Artist {
        string ipfs;
        bytes32 name;   // short name (up to 32 bytes)
        address[] albums;
        address[] singles;
    }
    //single

    mapping(address => Artist) public artists;
    mapping(bytes32 => address) public reserved_names;

    function create_artist(bytes32 username, string ipfs) {
       address[] storage albums;
       address[] storage singles;
       artists[msg.sender] = Artist({ipfs:ipfs, name:username, albums:albums,singles:singles});
       reserved_names[username] = msg.sender;

       NewArtistEvent(username, ipfs, msg.sender);

    }

    function create_album(string name) returns (address){
        address album = address(new Album(name));
        artists[msg.sender].albums.push(album);
        Artist artist = artists[msg.sender];
        NewAlbumEvent(artist.name, artist.ipfs, name, msg.sender);
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
        NewSongEvent(artist.name, artist.ipfs, name, ipfs, msg.sender);
        return song;

    }

    function get_artist_count() constant returns ( integer) {
      return artists.length;
    }
    function get_ipfs(bytes32 name ) constant returns ( string) {
        return artists[reserved_names[name]].ipfs;
    }
    function set_ipfs(string ipfs ) constant returns ( string) {
        artists[msg.sender].ipfs = ipfs;
    }

}

