// SPDX-License-Identifier: MIT

pragma solidity 0.8.10;

import {Errors} from '../../libraries/Errors.sol';
import {Events} from '../../libraries/Events.sol';
import {Escrow} from '@openzeppelin/contracts/utils/escrow/Escrow.sol';

/**
 * @title EscrowModule
 * @author 0x1uke.eth
 *
 * @notice This abstract contract adds a public `HUB` immutable to inheriting modules, as well as an
 * `onlyHub` modifier. Also, this file is meant to be in the Lens core. David, I can show you the 
 * branch I was woring on in the other repo later.
 */
abstract contract EscrowModule is Escrow {
    address public immutable HUB;

    modifier onlyHub() {
        if (msg.sender != HUB) revert Errors.NotHub();
        _;
    }

    constructor(address hub) {
        if (hub == address(0)) revert Errors.InitParamsInvalid();
        HUB = hub;
        emit Events.ModuleBaseConstructed(hub, block.timestamp);
    }
}