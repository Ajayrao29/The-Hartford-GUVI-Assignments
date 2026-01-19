const userAge: any = 25; 
console.log(`User age is: ${userAge}`); 
const userName: string = "Alice"; 
console.log(`User name is: ${userName}`);

//generic example typescript for boolean declaration
const isActive: boolean = true; 
console.log(`Is user active? ${isActive}`);

//merging two interfaces

interface product{
    id: number;
    name: string;
}
interface product{
    price: number;
    inStock:boolean;
}
const laptop:product={
    id:1,
    name:"Dell XPS 13",
    price:999.99,
    inStock:true
}

console.log(`Product Details: ${JSON.stringify(laptop)}`);

//enum example
enum Direction{
    North,
    South, 
    East,
    West
}
console.log(Direction[0]);

//basic function with typed parameters and return type
function add(a: number, b: number): number {
    return a + b;
}
console.log(`Sum: ${add(5, 10)}`);

//function overloading example
function combine(a: string, b: string): string;
function combine(a: number, b: number): number;
function combine(a: any, b: any): any

//Objects
const car = {    
    make: "Toyota",
    model: "Camry",
    year: 2020
};
console.log(car);

//objects with 

