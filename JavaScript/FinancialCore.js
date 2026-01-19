// FinancialCore.js
class FinancialAccount {
    constructor(accountNumber, accountHolder, balance = 0) {
        this.accountNumber = accountNumber;
        this.accountHolder = accountHolder;
        this._balance = balance;
        this.transactions = [];
        this.createdDate = new Date();
        this.accountType = "Base";
    }

    get balance() {
        return this._balance;
    }

    deposit(amount, description = "Deposit") {
        if (amount <= 0) {
            throw new Error("Deposit amount must be positive");
        }
        this._balance += amount;
        this._recordTransaction(amount, "credit", description);
    }
  
    withdraw(amount, description = "Withdrawal") {
        if (amount <= 0) {
            throw new Error("Withdrawal amount must be positive");
        }
        if (amount > this._balance) {
            throw new Error("Insufficient balance");
        }
        this._balance -= amount;
        this._recordTransaction(amount, "debit", description);
    }

    _recordTransaction(amount, type, description) {
        this.transactions.push({
            date: new Date(),
            type,
            amount,
            description,
            balanceAfter: this._balance
        });
    }
}

class SavingsAccount extends FinancialAccount {
    constructor(accountNumber, accountHolder, balance = 0, interestRate = 0.03) {
        super(accountNumber, accountHolder, balance);
        this.interestRate = interestRate;
        this.minimumBalance = 100;
        this.accountType = "Savings";
    }

    withdraw(amount, description = "Savings Withdrawal") {
        if (this._balance - amount < this.minimumBalance) {
            throw new Error("Cannot go below minimum balance");
        }
        super.withdraw(amount, description);
    }
}

class Bank {
    constructor(name) {
        this.name = name;
        this.accounts = [];
    }

    addAccount(account) {
        this.accounts.push(account);
    }

    findAccount(accountNumber) {
        return this.accounts.find(acc => acc.accountNumber === accountNumber);
    }
}

//Insurance 

// Insurance Policy Class

class InsurancePolicy {
    constructor(policyId, type, premium, coverageAmount, startDate) {
        this.policyId = policyId;
        this.type = type; // Health, Life, Vehicle
        this.premium = premium;
        this.coverageAmount = coverageAmount;
        this.startDate = startDate;
    }
}
// Insurance Service to manage policies
class InsuranceService {
    constructor() {
        this.policies = {}; // key: accountNumber, value: array of policies
    }

    addPolicy(accountNumber, policy) {
        if (!this.policies[accountNumber]) {
            this.policies[accountNumber] = [];
        }
        this.policies[accountNumber].push(policy);
    }

    getPolicies(accountNumber) {
        return this.policies[accountNumber] || [];
    }
}


module.exports = {
    Bank,
    SavingsAccount,
    InsurancePolicy,
    InsuranceService
};
