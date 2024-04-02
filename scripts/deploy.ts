import { ethers } from "hardhat";

async function main() {
  const smart = await ethers.deployContract("Owner");

  await smart.waitForDeployment();

  console.log(`Address: ${await smart.getAddress()}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
