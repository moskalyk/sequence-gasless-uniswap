import "@uniswap/v3-periphery/contracts/interfaces/ISwapRouter.sol";
import "@uniswap/v3-periphery/contracts/libraries/TransferHelper.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract UniswapSingleSwap is Ownable {
    ISwapRouter public routerAddress;

    address public constant DAI = 0x8f3Cf7ad23Cd3CaDbD9735AFf958023239c6A063;
    address public constant WETH9 = 0x7ceB23fD6bC0adD59E62ac25578270cFf1b9f619;
    uint24 public constant poolFee = 3000;

    constructor(ISwapRouter routerAddress_){
        routerAddress = routerAddress_;
    }

    function setRouterAddress(ISwapRouter routerAddress_) onlyOwner external {
        routerAddress = routerAddress_;
    }

    function callEthToDaiSwap(uint amountIn) external {
        // Transfer the specified amount of WETH9 to this contract.
        TransferHelper.safeTransferFrom(WETH9, msg.sender, address(this), amountIn);

        // Approve the router to spend WETH9.
        TransferHelper.safeApprove(WETH9, address(routerAddress), amountIn);

        // Naively set amountOutMinimum to 0. In production, use an oracle or other data source to choose a safer value for amountOutMinimum.
        // We also set the sqrtPriceLimitx96 to be 0 to ensure we swap our exact input amount.
        ISwapRouter.ExactInputSingleParams memory params =
            ISwapRouter.ExactInputSingleParams({
                tokenIn: WETH9,
                tokenOut: DAI,
                fee: poolFee,
                recipient: msg.sender,
                deadline: block.timestamp,
                amountIn: amountIn,
                amountOutMinimum: 0,
                sqrtPriceLimitX96: 0
            });

        // The call to `exactInputSingle` executes the swap.
        routerAddress.exactInputSingle(params);
    }

    function withdrawToken(address tokenAddress) external onlyOwner {
        IERC20 token = IERC20(tokenAddress);
        uint256 balance = token.balanceOf(address(this));
        token.transfer(owner(), balance);
    }
}