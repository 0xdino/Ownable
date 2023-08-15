import { loadFixture } from "@nomicfoundation/hardhat-toolbox/network-helpers";
import { expect } from "chai";
import { ethers } from "hardhat";

describe("Ownable", function () {
  async function deployOneYearLockFixture() {
    const [owner, otherAccount] = await ethers.getSigners();

    const Smart = await ethers.getContractFactory("Example");
    const smart = await Smart.deploy();

    return { smart, owner, otherAccount };
  }

  describe("Validation function of the smart contract", function () {
    it("Should set the right owner", async function () {
      const { smart, owner } = await loadFixture(deployOneYearLockFixture);

      expect(await smart.owner()).to.equal(owner.address);
    });

    it("Should the correct translation of the ownership right.", async function () {
      const { smart, owner, otherAccount } = await loadFixture(
        deployOneYearLockFixture
      );

      await expect(
        smart.connect(otherAccount).transferOwnership(otherAccount.address)
      ).to.revertedWithCustomError(smart, "NotOwner");

      await expect(smart.transferOwnership(otherAccount.address))
        .to.emit(smart, "OwnershipTransferred")
        .withArgs(owner.address, otherAccount.address);
    });

    it("Checking the execution of a function with the onlyOwner modifier", async function () {
      const { smart, owner, otherAccount } = await loadFixture(
        deployOneYearLockFixture
      );

      await expect(
        smart.connect(otherAccount).execution()
      ).to.revertedWithCustomError(smart, "NotOwner");

      expect(await smart._execution()).to.equal(false);

      await smart.connect(owner).execution();

      expect(await smart._execution()).to.equal(true);
    });
  });
});
