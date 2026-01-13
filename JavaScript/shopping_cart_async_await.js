const readline = require("readline");

// Create readline interface
const rl = readline.createInterface({
    input: process.stdin,
    output: process.stdout
});

let products = [];
let cart = [];

// Fetch products from API (local copy)
async function fetchProducts() {
    const response = await fetch("https://dummyjson.com/products");
    const data = await response.json();

    products = data.products.map(p => ({
        id: p.id,
        title: p.title,
        category: p.category,
        price: p.price,
        stock: p.stock
    }));

    console.log("\n📦 Products Loaded:");
    console.table(products);
}

// Add to cart and update LOCAL stock
function addToCart(productId, quantity) {
    const product = products.find(p => p.id === productId);

    if (!product) {
        console.log("❌ Product not found");
        return;
    }

    if (product.stock < quantity) {
        console.log("❌ Insufficient stock");
        return;
    }

    product.stock -= quantity;

    cart.push({
        id: product.id,
        title: product.title,
        quantity,
        price: product.price,
        total: product.price * quantity
    });

    console.log("\n✅ Added to cart");

    console.log("\n🛒 Cart:");
    console.table(cart);

    console.log("\n📦 Updated LOCAL Stock:");
    console.table(products);
}

// Terminal input
function askInput() {
    rl.question("\nEnter Product ID (or q to quit): ", id => {
        if (id.toLowerCase() === "q") {
            console.log("👋 Exiting...");
            rl.close();
            return;
        }

        rl.question("Enter Quantity: ", qty => {
            addToCart(Number(id), Number(qty));
            askInput();
        });
    });
}

// Start app
async function startApp() {
    await fetchProducts();
    askInput();
}

startApp();
