function calculateBusFare(busIndex, travelKm, travelHrs) {
   const baseKm = 100;
    const baseHrs = 24;
    const extraKmRate = 5;
    const extraHrRate = 3;
 
    const buses = [
        { type: "20 Seater", price: 5000 },
        { type: "30 Seater", price: 7000 },
        { type: "40 Seater", price: 9000 },
        { type: "50 Seater", price: 12000 }
    ];

    let extraKm = travelKm > baseKm ? travelKm - baseKm : 0;
    let extraHrs = travelHrs > baseHrs ? travelHrs - baseHrs : 0;

    let extraKmCost = extraKm * extraKmRate;
    let extraHrCost = extraHrs * extraHrRate;

    let totalAmount = buses[busIndex].price + extraKmCost + extraHrCost;

    console.log("Bus Type:", buses[busIndex].type);
    console.log("Distance:", travelKm, "km");
    console.log("Duration:", travelHrs, "hrs");
    console.log("Total Fare: ₹", totalAmount);
}

// Function call
calculateBusFare(1, 120, 30);   // 30 seater bus