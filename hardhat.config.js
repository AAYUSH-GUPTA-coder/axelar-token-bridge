require("@nomicfoundation/hardhat-toolbox");
require("@nomiclabs/hardhat-etherscan");
require("dotenv").config();

const QUICKNODE_MUMBAI_RPC_URL = process.env.QUICKNODE_MUMBAI_RPC_URL;
const PRIVATE_KEY = process.env.PRIVATE_KEY;
const POLYGONSCAN_API_KEY = process.env.POLYGONSCAN_API_KEY;
const AVALANCHE_API_KEY = process.env.AVALANCHE_API_KEY;
const QUICKNODE_FUJI_RPC_URL = process.env.QUICKNODE_FUJI_RPC_URL;

module.exports = {
  solidity: "0.8.17",
  defaultNetwork: "fuji",
  networks: {
    hardhat: {
      chainId: 31337,
      blockConfirmation: 1,
    },
    mumbai: {
      url: QUICKNODE_MUMBAI_RPC_URL,
      accounts: [PRIVATE_KEY],
    },
    fuji: {
      url: QUICKNODE_FUJI_RPC_URL,
      accounts: [PRIVATE_KEY],
      chainId: 43113,
    },
  },
  etherscan: {
    apiKey: {
      polygonMumbai: POLYGONSCAN_API_KEY,
      avalancheFujiTestnet: AVALANCHE_API_KEY,
    },
  },
};