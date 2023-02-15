//SPDX-License-Identifier: MIT
pragma solidity ^0.8.11;

import './SVG2.sol';
import './Utils.sol';
import { Base64 } from "base64-sol/base64.sol";
import {JBTokenStore} from "@jbx-protocol/juice-contracts-v3/contracts/JBTokenStore.sol"; // Example importing a JBP contract. Not used below.
import {IJBProjectHandles} from "@jbx-protocol/project-handles/contracts/interfaces/IJBProjectHandles.sol";

contract Renderer {
    function render(uint256 _tokenId) public pure returns (string memory) {
        uint256 id = _tokenId; // do something with me
        string[] memory parts = new string[](4);
        parts[0] = string('data:application/json;base64,');
        parts[1] = string(
            abi.encodePacked(
                '{"name":"XYZ",',
                '"description":"Description Text",',
                '"image":"data:image/svg+xml;base64,'
            )
        );
        parts[2] = Base64.encode(
            abi.encodePacked('<svg xmlns="http://www.w3.org/2000/svg" width="300" height="300" style="background:#000">',
                svg.text(
                    string.concat(
                        svg.prop('x', '20'),
                        svg.prop('y', '40'),
                        svg.prop('font-size', '22'),
                        svg.prop('fill', 'white')
                    ),
                    string.concat(
                        svg.cdata('Hello, token #'),
                        utils.uint2str(_tokenId)
                    )
                ),
                svg.rect(
                    string.concat(
                        svg.prop('fill', 'purple'),
                        svg.prop('x', '20'),
                        svg.prop('y', '50'),
                        svg.prop('width', utils.uint2str(160)),
                        svg.prop('height', utils.uint2str(10))
                    ),
                    utils.NULL
                ),
                '</svg>'
            )
        );
        parts[3] = string(abi.encodePacked('"}'));
        string memory uri = string.concat(
            parts[0],
            Base64.encode(abi.encodePacked(parts[1], parts[2], parts[3]))
            );
        return uri;    
    }

    function example() external pure returns (string memory) {
        return render(1);
    }
}