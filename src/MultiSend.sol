// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

contract MultiSend {
    error MultiSend__AddressZeroNotAllowed();
    error MultiSend__CannotSendEthToYourSelf();
    event MultiSend__EthNotSent(address);

    function sendEthToMultipleAddresses(address[] memory listOfAddresses) external payable {
        uint256 numberOfAddresses = listOfAddresses.length;
        uint256 ethPerAddress = msg.value / numberOfAddresses;
        for (uint256 i = 0; i < numberOfAddresses; i++) {
            require(listOfAddresses[i] != address(0), MultiSend__AddressZeroNotAllowed());
            require(listOfAddresses[i] != msg.sender, MultiSend__CannotSendEthToYourSelf());
            if (i == 0) {
                uint256 remainderEth = msg.value % numberOfAddresses;
                (bool success,) = payable(listOfAddresses[i]).call{value: (ethPerAddress + remainderEth)}("");
                if (!success) {
                    emit MultiSend__EthNotSent(listOfAddresses[i]);
                }
            }
            (bool success1,) = payable(listOfAddresses[i]).call{value: ethPerAddress}("");
            if (!success1) {
                emit MultiSend__EthNotSent(listOfAddresses[i]);
            }
        }
    }
}
