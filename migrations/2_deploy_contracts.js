var ConvertLib = artifacts.require("./ConvertLib.sol");
var Artists = artifacts.require("./Artists.sol");

module.exports = function(deployer) {
  deployer.deploy(ConvertLib);
  deployer.link(ConvertLib, Artists);
  deployer.deploy(Artists);
};
