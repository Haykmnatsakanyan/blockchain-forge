// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.13;

import "ds-test/test.sol";
import "../src/FootballLeagueTokens.sol";

contract FootballLeagueTokensTest is DSTest {

    FootballLeagueTokens public footballLeagueTokens;

    function setUp() public {
        footballLeagueTokens = new FootballLeagueTokens();
    }

    function testMitnByEth() public {
        footballLeagueTokens.mintByETH(0, 0);
        assertTrue(1);
    }
}
