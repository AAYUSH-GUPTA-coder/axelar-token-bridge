const hre = require("hardhat");
require("@nomiclabs/hardhat-etherscan");

async function main() {
  const SendToken = await hre.ethers.getContractFactory("SendToken");
  const sendToken = await SendToken.deploy(); 
  await sendToken.deployed();
  console.log("sendToken deployed to:", sendToken.address);

  console.log("Sleeping.....");
  // Wait for etherscan to notice that the sendToken has been deployed
  await sleep(100000); // 100 seconds

  // Verify the sendToken after deploying
  await hre.run("verify:verify", {
    address: sendToken.address,
    constructorArguments: [],
    contract: "contracts/SendToken.sol:SendToken",
  });
}

function sleep(ms) {
  return new Promise((resolve) => setTimeout(resolve, ms));
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });