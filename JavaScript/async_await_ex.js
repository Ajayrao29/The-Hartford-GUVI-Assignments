async function fetchProducts() {
    try {
        // Fetch data
        const response = await fetch("https://dummyjson.com/products");

        // Convert response to JSON
        const data = await response.json();

        // Extract required fields
        const products = data.products.map(product => ({
            id: product.id,
            title: product.title,
            price: product.price,
            stock: product.stock,
            brand: product.brand
        }));

        // Display in table format
        console.table(products);

    } catch (error) {
        console.error("Error fetching products:", error);
    }
}

// Call the function
fetchProducts();
