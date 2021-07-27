const Rupee = artifacts.require("Rupee");
const OneBank = artifacts.require("OneBank");

module.exports = async function (deployer) {
	//deploy Token
	await deployer.deploy(Rupee);

	//assign token into variable to get it's address\
	const rupee  = await  Rupee.deployed();
	
	//pass token address for dBank contract(for future minting)
	await deployer.deploy(OneBank,rupee.address);
	
	//assign dBank contract into variable to get it's address
	const oneBank  = await OneBank.deployed();
	
	//change token's owner/minter from deployer to dBank
	await rupee.passMintRole(oneBank.address);
};