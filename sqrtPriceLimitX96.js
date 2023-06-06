const WETH_PRICE = 1805.50;  // Price of 1 WETH in DAI
const PRICE_RANGE_MULTIPLIER = 0.9;  // Multiplier for price range (adjust as needed)

function calculateSqrtPriceLimit(wethAmount, daiAmount) {
  // Calculate the reference price of the swap pair (WETH9 to DAI)
  const referencePrice = daiAmount / wethAmount;

  // Calculate the price range limit as a percentage of the reference price
  const priceRangeLimit = referencePrice * PRICE_RANGE_MULTIPLIER;

  // Calculate the square root of the price range limit multiplied by 2^96
  const sqrtPriceLimitX96 = Math.floor(Math.sqrt(priceRangeLimit) * 2 ** 96);

  return sqrtPriceLimitX96;
}

// Example usage
const wethAmount = .01;  // Amount of WETH9
const daiAmount = wethAmount * WETH_PRICE;  // Equivalent amount of DAI

const sqrtPriceLimit = calculateSqrtPriceLimit(wethAmount, daiAmount);
console.log("sqrtPriceLimitX96:", parseFloat(sqrtPriceLimit));