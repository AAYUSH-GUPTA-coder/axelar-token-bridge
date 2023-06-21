// SPDX-License-Identifier: AGPL-3.0

pragma solidity 0.8.17;

import {IAxelarGateway} from "@axelar-network/axelar-gmp-sdk-solidity/contracts/interfaces/IAxelarGateway.sol";
import {IERC20} from "@openzeppelin/contracts/token/ERC20/IERC20.sol";

error ONLY_OWNER_CAN_CALL();

contract SendToken {
    /// @notice variable to store the IAxelarGateway
    IAxelarGateway public immutable gateway;

    /// @notice variable to store the ERC20 Token
    IERC20 public immutable token;

    /// @notice address of the owner
    address private owner;

    /// @notice modifier to check that only the owner address can call the function
    modifier onlyOwner() {
        if (msg.sender != owner) {
            revert ONLY_OWNER_CAN_CALL();
        }
        _;
    }

    /**
     * @notice constructor to set gateway and token address
     * @param _gateway address of the gateway of the Blockchain you are sending token from
     * @param _token address of the erc20 token of the Blockchain you are sending token from
     */
    constructor(address _gateway, address _token, address _owner) {
        gateway = IAxelarGateway(_gateway);
        token = IERC20(_token);
        owner = _owner;
    }

    /**
     * @notice function to send token from Polygon chain to Avalance chain
     * @param _amount amount of token
     */
    function send(
        uint _amount,
        string calldata _receiver,
        string calldata _blockchain,
        string calldata _tokenName
    ) external {
        token.approve(address(gateway), _amount);
        gateway.sendToken(
            _blockchain, // network to send
            _receiver, // address to send
            _tokenName, // token name
            _amount // amount of token
        );
    }

    /**
     * @notice function to withdraw tokens from the contract
     * @param _receiver address of the receiver
     * @param _amount amount of tokens
     */
    function withdraw(address _receiver, uint _amount) external onlyOwner {
        token.transfer(_receiver, _amount);
    }

    /**
     * @notice function to change the owner of this smart contract
     * @param _newOwner address of the new owner
     */
    function changeOwner(address _newOwner) external onlyOwner {
        owner = _newOwner;
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
    function getUserBalance(address _user) external view returns (uint) {
        return token.balanceOf(_user);
    }

    /**
     * @notice function to get the address of the owner
     */
    function getOwner() external view returns (address) {
        return owner;
    }
}
