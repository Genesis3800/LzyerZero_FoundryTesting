// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.19;

import {Test, console2} from "forge-std/Test.sol";

import {LZEndpointMock} from "@layerzero-contracts/mocks/LZEndpointMock.sol";

import {OmniCounter_Sepolia} from "../src/OmniCounter_Sepolia.sol";
import {OmniCounter_Mumbai} from "../src/OmniCounter_Mumbai.sol";

contract OmniCounterTest is Test {

    LZEndpointMock public lzEndpointMock;

    OmniCounter_Sepolia public omniCounter_Sepolia;
    OmniCounter_Mumbai public omniCounter_Mumbai;

    uint16 public ChainId = 1221;

    function setUp() public {

        vm.deal(address(0x1), 100 ether);
        vm.deal(address(0x2), 100 ether);
        vm.deal(address(0x3), 100 ether);

        vm.prank(address(0x1));
        lzEndpointMock = new LZEndpointMock(ChainId);
        address mockAddress = address(lzEndpointMock);

        vm.prank(address(0x2));
        omniCounter_Sepolia = new OmniCounter_Sepolia(mockAddress);

        vm.prank(address(0x3));
        omniCounter_Mumbai = new OmniCounter_Mumbai(mockAddress);

        vm.deal(mockAddress, 100 ether);
        vm.deal(address(omniCounter_Sepolia), 100 ether);
        vm.deal(address(omniCounter_Mumbai), 100 ether);


        vm.startPrank(address(0x1));
        lzEndpointMock.setDestLzEndpoint(address(omniCounter_Sepolia), mockAddress);
        lzEndpointMock.setDestLzEndpoint(address(omniCounter_Mumbai), mockAddress);
        vm.stopPrank();
        
        bytes memory omniCounter_Mumbai_Address = abi.encodePacked(uint160(address(omniCounter_Mumbai)));
        bytes memory omniCounter_Sepolia_Address = abi.encodePacked(uint160(address(omniCounter_Sepolia)));


        vm.prank(address(0x2));
        omniCounter_Sepolia.setTrustedRemoteAddress(ChainId, omniCounter_Mumbai_Address);

        vm.prank(address(0x3));
        omniCounter_Mumbai.setTrustedRemoteAddress(ChainId, omniCounter_Sepolia_Address);

    }

    function test_SepoliaToMumbai() public {

        uint counter_initial = omniCounter_Sepolia.counter();
        console2.log("counter_initial", counter_initial);

        vm.deal(address(0x10), 100 ether);
        vm.prank(address(0x10));
        omniCounter_Sepolia.incrementCounter{value: 1 ether}(ChainId);
        assertEq(omniCounter_Mumbai.counter(), counter_initial+1);
        //console2.log("counter_final", omniCounter_Mumbai.counter());
    }
 
}
