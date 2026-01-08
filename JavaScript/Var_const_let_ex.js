// Customer information
const customerName = "Ajay";
const bookingType = "Farmhouse Booking";
const basePricePerDay = 20000;
const taxRate = 0.18;

// Initial booking details
let numberOfCustomers = 4;

// Calculate tax and total amount
let taxAmount = basePricePerDay * taxRate;
let totalAmount = basePricePerDay + taxAmount;

console.log("Customer Name:", customerName);
console.log("Booking Type:", bookingType);
console.log("Number of Customers:", numberOfCustomers);
console.log("Total Amount for 4 customers:", totalAmount);

// If one extra person is added
numberOfCustomers += 1;

// 10% increment on total price
let incrementAmount = totalAmount * 0.10;
let newTotalAmount = totalAmount + incrementAmount;

console.log("Updated Number of Customers:", numberOfCustomers);
console.log("Total Amount after adding 1 extra person:", newTotalAmount);
