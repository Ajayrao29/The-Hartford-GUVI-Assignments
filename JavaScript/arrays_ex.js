// Squaring the numbers in an array using map()----------------------------------------------------------------------

// Array
const numbers = [2, 4, 6, 8, 10];

// Using map() to square each number
const squaredNumbers = numbers.map(function (num) {
    return num * num;   // Square of each number
});

// Print the resultconsole.log("Original Array:", numbers);
console.log("1.Squared Array:", squaredNumbers);

//perform sum of squares of even numbers----------------------------------------------------------------------------

const sumOfSquares = numbers
    .filter(function (num) {
        return num % 2 === 0; // Filter even numbers    
    })
    .map(function (num) {
        return num * num;   // Square of each even number
    })
    .reduce(function (acc, num) {
        return acc + num;   // Sum of squared even numbers
    }, 0);

console.log("Sum of Squared Even Numbers:", sumOfSquares);

//----------------------------------------------------------------------------------------------------------------------

/*You are given N numbers in the form of an array. You have to select K numbers from these numbers.
You can only select numbers from the ends (either front or last).
The selected number gets erased from the array.
You want to maximize the sum of the selected K numbers.Array: [5, 6, 4, 8, 7, 7, 6, 5, 4]
K = 4 explin the mathamatically*/

function maxSumFromEnds(arr, k) {
    const n = arr.length;

    // Step 1: Calculate total sum of array
    let totalSum = arr.reduce((sum, val) => sum + val, 0);

    // Step 2: Size of subarray to exclude
    const windowSize = n - k;

    // Step 3: Find minimum subarray sum of size (n - k)
    let windowSum = 0;
    let minWindowSum = Infinity;

    for (let i = 0; i < n; i++) {
        windowSum += arr[i];

        // Maintain window size
        if (i >= windowSize - 1) {
            minWindowSum = Math.min(minWindowSum, windowSum);
            windowSum -= arr[i - (windowSize - 1)];
        }
    }

    // Step 4: Max sum = total sum - min window sum
    return totalSum - minWindowSum;
}

// Input
const arr = [5, 6, 4, 8, 7, 7, 6, 5, 4];
const k = 4;

// Output
console.log("2.Maximum Sum:", maxSumFromEnds(arr, k));


/*The task is to maximize the sum of numbers from an array, given a multiplier array where each element
 is multiplied with the corresponding number chosen.
  The provided example shows two arrays: [1, 1, 1, 20, 2, 3, 4, 5, 6] and [2, 2, 2, 1].*/
    
let nums = [1, 1, 1, 20, 2, 3, 4, 5, 6];
let mult = [2, 2, 2, 1];

let sum = 0;

for (let i = 0; i < mult.length; i++) {
    // always pick the larger end
    if (nums[0] > nums[nums.length - 1]) {
        sum += nums.shift() * mult[i];
    } else {
        sum += nums.pop() * mult[i];
    }
}

console.log("3.Maximum Score:", sum);
