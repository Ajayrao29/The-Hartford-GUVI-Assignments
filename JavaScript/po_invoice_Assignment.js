// Generate ID:
function generateId() {
    const letters = "ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    let id = "";                                              

    for (let i = 0; i < 3; i++) {
        id += letters[Math.floor(Math.random() * letters.length)];
    }

    id += Math.floor(100 + Math.random() * 900); // 3 digits
    return id;
}

// Add days to a date
function addDays(date, days) {
    const newDate = new Date(date);
    newDate.setDate(newDate.getDate() + days);
    return newDate;
}

/*PURCHASE ORDER*/

function createPurchaseOrder(trainer, training, paymentType, rate, duration) {

    let totalAmount = 0;

    // Payment calculation
    switch (paymentType) {
        case "Hourly":
            totalAmount = rate * duration;
            break;
        case "Daily":
            totalAmount = rate * duration;
            break;
        case "Monthly":
            totalAmount = rate * duration;
            break;
        default:
            console.log("Invalid payment type");
            return null;
    }

    return {
        poNumber: generateId(),
        trainer: trainer,
        training: training,
        paymentType: paymentType,
        rate: rate,
        duration: duration,
        totalAmount: totalAmount
    };
}

/*INVOICE GENERATION*/

function generateInvoice(po) {

    const today = new Date();
    const trainingEndDate = new Date(po.training.endDate);

    // Invoice only after training completion
    if (today < trainingEndDate) {
        console.log("⚠️ Training not completed. Invoice cannot be generated.");
        return null;
    }

    const invoiceDate = today;
    const dueDate = addDays(invoiceDate, 30);

    return {
        invoiceNumber: generateId(),
        poNumber: po.poNumber,
        trainerName: po.trainer.name,
        courseName: po.training.courseName,
        totalAmount: po.totalAmount,
        invoiceDate: invoiceDate,
        dueDate: dueDate,
        paymentStatus: "UNPAID"
    };
}

/*OVERDUE CHECK*/

function checkOverdue(invoice) {
    const today = new Date();

    if (invoice.paymentStatus === "UNPAID" && today > invoice.dueDate) {
        invoice.paymentStatus = "OVERDUE";
        sendOverdueEmail(invoice);
    }
}

// Simulated email notification
function sendOverdueEmail(invoice) {
    console.log("📧 EMAIL SENT TO ACCOUNTS TEAM");
    console.log(
        `Invoice ${invoice.invoiceNumber} for PO ${invoice.poNumber} is OVERDUE.
Trainer: ${invoice.trainerName}
Amount: ₹${invoice.totalAmount}`
    );
}

/* DEMO EXECUTION*/

// Trainer details
const trainer = {
    name: "Sharath Kumar",
    email: "sharath@gmail.com",
    experience: "5 Years"
};

// Training details
const training = {
    courseName: "Java Full Stack Development",
    clientName: "ABC Corp",
    startDate: "2024-01-01",
    endDate: "2024-05-31"
};

// Create Purchase Order
const po = createPurchaseOrder(
    trainer,
    training,
    "Monthly",
    100000,
    5
);

console.log("----- PURCHASE ORDER -----");
console.log(po);

// Generate Invoice
const invoice = generateInvoice(po);

if (invoice) {
    console.log("----- INVOICE -----");
    console.log(invoice);

    // Simulate overdue (for demo)
    invoice.dueDate = addDays(new Date(), -5); // force overdue
    checkOverdue(invoice);

    console.log("----- FINAL INVOICE STATUS -----");
    console.log(invoice.paymentStatus);
}
