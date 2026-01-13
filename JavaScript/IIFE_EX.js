(function () {

    const baseRate = 2500;
    const highRiseCharge = 10;
    const parkingCost = 100000;
    const floorNumber = 10;

    const flats = [
        { type: "2BHK", area: 1200 },
        { type: "3BHK", area: 1800 }
    ];

    flats.forEach(flat => {

        let ratePerSft = baseRate;

        // High-rise charge applicable after 5th floor
        if (floorNumber > 5) {
            ratePerSft += highRiseCharge;
        }

        // Total flat cost
        let flatCost = (ratePerSft * flat.area) + parkingCost;

        console.log("Floor Number:", floorNumber);
        console.log("Flat Type:", flat.type);
        console.log("Area (sq.ft):", flat.area);
        console.log("Rate per sq.ft: ₹", ratePerSft);
        console.log("Total Cost: ₹", flatCost);
        console.log("----------------------------");
    });

})();
