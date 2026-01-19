var userAge = 25;
console.log("User age is: ".concat(userAge));
var userName = "Alice";
console.log("User name is: ".concat(userName));
//generic example ts for boolean declaration
var isActive = true;
console.log("Is user active? ".concat(isActive));
var laptop = {
    id: 1,
    name: "Dell XPS 13",
    price: 999.99,
    inStock: true
};
console.log("Product Details: ".concat(JSON.stringify(laptop)));
//enum example
var Direction;
(function (Direction) {
    Direction[Direction["North"] = 0] = "North";
    Direction[Direction["South"] = 1] = "South";
    Direction[Direction["East"] = 2] = "East";
    Direction[Direction["West"] = 3] = "West";
})(Direction || (Direction = {}));
console.log(Direction[0]);
