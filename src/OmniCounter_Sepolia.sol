// SPDX-License-Identifier: MIT

pragma solidity ^0.8.19;

import "@layerzero-contracts/lzApp/NonblockingLzApp.sol";

contract OmniCounter_Sepolia is NonblockingLzApp {
    bytes public constant PAYLOAD = "Sepolia_to_Mumbai";
    uint public counter;

    constructor(address _lzEndpoint) NonblockingLzApp(_lzEndpoint) {}

    function incrementCounter(uint16 _dstChainId) public payable {
        _lzSend(_dstChainId, PAYLOAD, payable(msg.sender), address(0x0), bytes(""), msg.value);
    }

        function _nonblockingLzReceive(uint16, bytes memory, uint64, bytes memory) internal override {
        counter += 1;
    }

    function estimateFee(uint16 _dstChainId, bool _useZro, bytes calldata _adapterParams) public view returns (uint nativeFee, uint zroFee) {
        return lzEndpoint.estimateFees(_dstChainId, address(this), PAYLOAD, _useZro, _adapterParams);
    }
}