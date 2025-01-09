// SPDX-License-Identifier: MIT
pragma solidity ^0.8.28;

import "./Precompiles.sol";

struct ProgrammableDataArgs {
    uint32 range_index;
    uint32 offset;
    uint16 count;
}

library ProgrammableData {
    function readChunks(
        uint32 range_index,
        uint32 offset,
        uint16 count
    ) public view returns (bytes memory) {
        bytes memory data = abi.encodePacked(range_index, offset, count);

        // call the precompile
        (bool success, bytes memory chunks) = address(
            PD_READ_PRECOMPILE_ADDRESS
        ).staticcall(data);
        require(success, "reading chunks failed");
        return chunks;
    }
}
