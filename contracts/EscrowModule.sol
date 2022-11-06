// SPDX-License-Identifier: MIT

pragma solidity 0.8.10;

import {Errors} from '../../libraries/Errors.sol';
import {Events} from '../../libraries/Events.sol';
import {Escrow} from '@openzeppelin/contracts/utils/escrow/Escrow.sol';

/**
 * @title EscrowModule
 * @author 0x1uke.eth
 *
 * @notice This is a module that clones an escrow contract that is associated
 * with a Lens post and owned by the post creator.
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