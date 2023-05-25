// SPDX-License-Identifier: AGPL-3.0

pragma solidity 0.8.17;

import { IAxelarGateway } from "@axelar-network/axelar-gmp-sdk-solidity/contracts/interfaces/IAxelarGateway.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract sendToken {
    IAxelarGateway public immutable gateway;
    IERC20 public immutable token;

    constructor(address gateway_, address token_){
        gateway = IAxelarGateway(gateway_);
        token = IERC20(token_);
    }

    function send(uint _amount) public {
        token.approve(address(gateway), _amount);
        gateway.sendToken(
            "Avalanche", // network to send
            "0x4E476F7FB84c785557cDECdbf8CADEbE8EA57C37", // address to send
            "aUSDC",
            _amount
        );
    }

    function withdraw(address _receiver, uint _amount) public {
        token.transfer(_receiver, _amount);
    }
}

// gateway_ : 0xBF62ef1486468a6bd26Dd669C06db43dEd5B849B
// token_ : 0x2c852e740B62308c46DD29B982FBb650D063Bd07