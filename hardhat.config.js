require("@nomicfoundation/hardhat-toolbox");

require("dotenv").config();
/** @type import('hardhat/config').HardhatUserConfig */

const key = process.env.PRIVATE_KEY;
module.exports = {
  solidity: "0.8.17",
  defaultNetwork: 'sepolia',
    networks: {
      hardhat: {},
      sepolia: {
        url: "https://eth-sepolia.g.alchemy.com/v2/mKWeUfHKniwSn0E8sepybb09NgaXUoKq",
        accounts: [`0x${key}`]
      }
    }
};
