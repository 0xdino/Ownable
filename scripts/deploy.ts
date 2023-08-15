import { ethers } from "hardhat";

async function main() {
  const smart = await ethers.deployContract("Example");

  await smart.waitForDeployment();

  console.log(`Smart: ${await smart.getAddress()}`);
}

main().catch((error) => {
  console.error(error);
  process.exitCode = 1;
});
