console.log("===== DAY 3: FUNCTIONS & SCOPE IN JAVASCRIPT =====");

/* 1. FUNCTION DECLARATION */
console.log("\n1. Function Declaration");

function greetDeclaration() {
  console.log("Hello from Function Declaration");
}

greetDeclaration();

/* 2. FUNCTION EXPRESSION */
console.log("\n2. Function Expression");

const greetExpression = function () {
  console.log("Hello from Function Expression");
};

greetExpression();

/* 3. ARROW FUNCTION */
console.log("\n3. Arrow Function");

const greetArrow = () => {
  console.log("Hello from Arrow Function");
};

greetArrow();

/* Arrow function with return */
const add = (a, b) => a + b;
console.log("Addition (5 + 3):", add(5, 3));


/* 4. PARAMETERS & ARGUMENTS */
console.log("\n4. Parameters & Arguments");

function multiply(x, y) {
  return x * y;
}

console.log("Multiplication (4 * 5):", multiply(4, 5));


/* 5. RETURN VALUE */
console.log("\n5. Return Value");

function square(n) {
  return n * n;
}

let squareResult = square(6);
console.log("Square of 6:", squareResult);


/* 6. DEFAULT PARAMETERS */
console.log("\n6. Default Parameters");

function greetWithDefault(name = "Guest") {
  console.log("Hello " + name);
}

greetWithDefault();
greetWithDefault("Ajay");


/* 7. GLOBAL SCOPE */
console.log("\n7. Global Scope");

let globalVar = 100;

function showGlobal() {
  console.log("Global variable:", globalVar);
}

showGlobal();


/* 8. LOCAL SCOPE */
console.log("\n8. Local Scope");

function showLocal() {
  let localVar = 50;
  console.log("Local variable:", localVar);
}

showLocal();
// console.log(localVar); // ❌ Error if uncommented

/* 9. CLOSURE */
console.log("\n9. Closure Example");

function outerFunction() {
  let count = 0;

  function innerFunction() {
    count++;
    console.log("Count:", count);
  }

  return innerFunction;
}

const counter = outerFunction();
counter();
counter();
counter();

/* -------------------------------------------------- */
/* 10. HOISTING (FUNCTION DECLARATION) */
console.log("\n10. Hoisting - Function Declaration");

hoistedFunction();

function hoistedFunction() {
  console.log("This function is hoisted");
}

/* -------------------------------------------------- */
/* 11. HOISTING (FUNCTION EXPRESSION) */
console.log("\n11. Hoisting - Function Expression");

// sayHi(); // ❌ Uncomment to see error

const sayHi = function () {
  console.log("This function is NOT hoisted");
};

sayHi();

/* -------------------------------------------------- */
/* 12. CALLBACK FUNCTION */
console.log("\n12. Callback Function");

function greetUser(name, callback) {
  console.log("Hello " + name);
  callback();
}

function goodbye() {
  console.log("Goodbye!");
}

greetUser("Ajay", goodbye);

/* Callback using arrow function */
greetUser("Ajay", () => {
  console.log("See you again!");
});

/* -------------------------------------------------- */
/* 13. CALLBACK WITH setTimeout */
console.log("\n13. Callback with setTimeout");

setTimeout(() => {
  console.log("This message appears after 2 seconds");
}, 2000);

console.log("\n===== END OF DAY 3 CODE =====");
