// SPDX-License-Identifier: AGPL-3.0

pragma solidity 0.8.17;

import {IAxelarGateway} from "@axelar-network/axelar-gmp-sdk-solidity/contracts/interfaces/IAxelarGateway.sol";
import "@openzeppelin/contracts/token/ERC20/IERC20.sol";

contract sendToken {
    /// @notice variable to store the IAxelarGateway
    IAxelarGateway public immutable gateway;

    /// @notice variable to store the ERC20 Token
    IERC20 public immutable token;

    /**
     * @notice constructor to set gateway and token address
     * @param gateway_ address of the gateway
     * @param token_ address of the erc20 token
     */
    constructor(address gateway_, address token_) {
        gateway = IAxelarGateway(gateway_);
        token = IERC20(token_);
    }

    /**
     * @notice function to send token from Polygon chain to Avalance chain
     * @param _amount amount of token
     */
    function send(uint _amount) public {
        token.approve(address(gateway), _amount);
        gateway.sendToken(
            "Avalanche", // network to send
            "0x4E476F7FB84c785557cDECdbf8CADEbE8EA57C37", // address to send
            "aUSDC", // token name
            _amount // amount of token
        );
    }

    /**
     * @notice function to withdraw tokens from the contract
     * @param _receiver address of the receiver
     * @param _amount amount of tokens
     */
    function withdraw(address _receiver, uint _amount) public {
        token.transfer(_receiver, _amount);
    }

    //////////////// Getter Funtions /////////////////
    /**
     * @notice function to get the Token balance of the smart contract
     */
    function getBalance() external view returns (uint) {
        return token.balanceOf(address(this));
    }

    /**
     * @notice function to get the token balance of the user
     */
    function getBalance(address _user) external view returns (uint) {
        return token.balanceOf(_user);
    }
}

// gateway_ : 0xBF62ef1486468a6bd26Dd669C06db43dEd5B849B
// token_ : 0x2c852e740B62308c46DD29B982FBb650D063Bd07
