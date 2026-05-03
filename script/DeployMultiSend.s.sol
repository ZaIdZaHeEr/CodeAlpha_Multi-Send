// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import {MultiSend} from "../src/MultiSend.sol";
import {Script} from "lib/forge-std/src/Script.sol";

contract DeployMultiSend is Script {
    function run() external {
        vm.startBroadcast();
        new MultiSend();
        vm.stopBroadcast();
    }
}