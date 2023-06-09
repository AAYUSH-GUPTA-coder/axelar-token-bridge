const hre = require("hardhat");
require("@nomiclabs/hardhat-etherscan");

// variables value for Mumbai testnetwork
// const IAxelarGateway = "0xBF62ef1486468a6bd26Dd669C06db43dEd5B849B";
// const tokenAddress = "0x2c852e740B62308c46DD29B982FBb650D063Bd07";

// variables value for Fuji (Avalanche) testnetwork
const IAxelarGateway = "0xC249632c2D40b9001FE907806902f63038B737Ab";
const tokenAddress = "0x57F1c63497AEe0bE305B8852b354CEc793da43bB";

const owner = "0x4E476F7FB84c785557cDECdbf8CADEbE8EA57C37"

async function main() {
  const SendToken = await hre.ethers.getContractFactory("SendToken");
  const sendToken = await SendToken.deploy(IAxelarGateway, tokenAddress, owner); 
  await sendToken.deployed();
  console.log("sendToken deployed to:", sendToken.address);

  console.log("Sleeping.....");
  // Wait for etherscan to notice that the sendToken has been deployed
  await sleep(100000); // 100 seconds

  // Verify the sendToken after deploying
  await hre.run("verify:verify", {
    address: sendToken.address,
    constructorArguments: [IAxelarGateway, tokenAddress, owner],
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