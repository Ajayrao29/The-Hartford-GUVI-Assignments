function maxProduct(arr) {
  let first = -Infinity;
  let second = -Infinity;

  for (let i = 0; i < arr.length; i++) {
    if (arr[i] > first) {
      second = first;
      first = arr[i];
    } else if (arr[i] > second) {
      second = arr[i];
    }
  }
  return first * second;
}

let arr = [2, 7, 10, 15, 5, 7, 14];
console.log(maxProduct(arr)); 
