const Hello = artifacts.require("FoxEnd");

module.exports = function (deployer) {

    deployer.deploy(Hello);
}