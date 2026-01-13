// FinancialConsoleApp.js

const readline = require("readline");
const {
    Bank,
    SavingsAccount,
    InsurancePolicy,
    InsuranceService
} = require("./FinancialCore.js");

// ================= BANK & ACCOUNTS =================

// Create Bank
const bank = new Bank("Global Finance Bank");

// Create Accounts
const acc1 = new SavingsAccount("A00145", "Ajay", 5000);
const acc2 = new SavingsAccount("A00146", "Rahul", 3000);
const acc3 = new SavingsAccount("A00147", "Vishal", 7000);
const acc4 = new SavingsAccount("A00148", "Rakesh", 9000);
const acc5 = new SavingsAccount("A00149", "Vishal", 8000);
const acc6 = new SavingsAccount("A00150", "Neha", 17000);

// Add accounts to bank
bank.addAccount(acc1);
bank.addAccount(acc2);
bank.addAccount(acc3);
bank.addAccount(acc4);
bank.addAccount(acc5);
bank.addAccount(acc6);

// ================= TRANSACTIONS =================

acc1.deposit(1000, "Salary");
acc1.withdraw(2000, "Rent");

acc2.deposit(500, "Bonus");
acc2.withdraw(1000, "Shopping");

acc3.deposit(2000, "Freelance Work");

acc4.deposit(3000, "Project Payment");
acc4.withdraw(1500, "Groceries");
acc4.withdraw(2000, "Electricity Bill");

acc5.deposit(1200, "Gift Received");
acc5.withdraw(800, "Online Shopping");
acc5.deposit(2500, "Freelance Bonus");

acc6.deposit(5000, "Monthly Salary");
acc6.withdraw(3000, "House Rent");
acc6.withdraw(2000, "Travel Expenses");

// ================= INSURANCE =================

const insuranceService = new InsuranceService();

const policy1 = new InsurancePolicy("P1001", "Health", 5000, 500000, "2024-01-01");
const policy2 = new InsurancePolicy("P1002", "Life", 8000, 1000000, "2023-06-15");
const policy3 = new InsurancePolicy("P1003", "Vehicle", 3000, 300000, "2024-03-10");

insuranceService.addPolicy("A00145", policy1);
insuranceService.addPolicy("A00145", policy2);
insuranceService.addPolicy("A00146", policy3);

// ================= CONSOLE =================

const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

// 1️⃣ DISPLAY ALL CUSTOMERS
console.log("\n=== ALL CUSTOMERS ===");
console.table(
    bank.accounts.map(acc => ({
        AccountNumber: acc.accountNumber,
        HolderName: acc.accountHolder,
        AccountType: acc.accountType,
        Balance: acc.balance.toFixed(2)
    }))
);

// 2️⃣ ASK ACCOUNT NUMBER
rl.question("\nEnter Account Number to view transactions: ", accountNumber => {
    const account = bank.findAccount(accountNumber);

    if (!account) {
        console.log("❌ Account not found");
        rl.close();
        return;
    }

    // 3️⃣ DISPLAY TRANSACTIONS
    console.log(`\n=== Transactions for ${account.accountHolder} (${account.accountNumber}) ===`);

    if (account.transactions.length === 0) {
        console.log("No transactions available");
    } else {
        console.table(
            account.transactions.map(t => ({
                Date: t.date.toLocaleString(),
                Type: t.type,
                Amount: t.amount,
                Description: t.description,
                BalanceAfter: t.balanceAfter
            }))
        );
    }

    // 4️⃣ ASK FOR INSURANCE
    rl.question("\nDo you want to view insurance details? (yes/no): ", answer => {
        if (answer.toLowerCase() === "yes") {
            showInsuranceDetails(accountNumber);
        }
        rl.close();
    });
});

// ================= FUNCTIONS =================

function showInsuranceDetails(accountNumber) {
    const policies = insuranceService.getPolicies(accountNumber);

    if (policies.length === 0) {
        console.log("\nNo insurance policies found.");
        return;
    }

    console.log("\n=== INSURANCE POLICIES ===");
    console.table(
        policies.map(p => ({
            PolicyID: p.policyId,
            Type: p.type,
            Premium: p.premium,
            Coverage: p.coverageAmount,
            StartDate: p.startDate
        }))
    );
}
