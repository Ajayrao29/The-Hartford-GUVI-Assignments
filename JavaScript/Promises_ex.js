// Fetch products using Promises
fetch("https://dummyjson.com/products")
    .then(response => response.json())   // Convert response to JSON
    .then(data => {
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
    })
    .catch(error => {
        console.error("Error fetching products:", error);
    });
