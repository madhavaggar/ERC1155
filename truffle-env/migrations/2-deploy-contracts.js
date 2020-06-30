var Endurance1155 = artifacts.require("./Endurance1155.sol");
var MockProxyRegistry = artifacts.require("./MockProxyRegistry.sol")

module.exports = function(deployer) {
  let proxyRegistryAddress;
  proxyRegistryAddress = "0xf57b2c51ded3a29e6891aba85459d600256cf317";
  deployer.deploy(MockProxyRegistry);
  deployer.deploy(Endurance1155,'Endurance', 'en', proxyRegistryAddress,  {gas: 5000000});
};