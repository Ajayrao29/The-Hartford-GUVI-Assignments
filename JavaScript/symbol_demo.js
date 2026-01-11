// Create a symbol for Employee ID
const empId = Symbol("employeeId");

// Employee data object
const employee = {
    name: "Ajay",
    email: "ajay@gmail.com",
    phone: "9876543210",
    [empId]: "EMP101"
};

// Print employee data
console.log("Employee Name:", employee.name);
console.log("Employee Email:", employee.email);
console.log("Employee Phone:", employee.phone);
console.log("Employee ID:", employee[empId]);

