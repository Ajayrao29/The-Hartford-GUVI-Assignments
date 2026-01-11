console.log(a);
var a=10;


sayHello();
function sayHello(){
    console.log("Hello, World!");
}
//Output will be:Hello world.


sayHello();
var sayHello = function(){
    console.log("Hello again!");
}
//Output will be error.

