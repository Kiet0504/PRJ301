<!DOCTYPE html>
<html>
    <head>
        <meta charset="UTF-8">
        <title>Add Product</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
                background-color: #f4f4f4;
            }
            .container {
                background-color: white;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                width: 300px;
            }
            h2 {
                margin-bottom: 20px;
                color: #333;
                text-align: center;
            }
            label {
                display: block;
                margin-bottom: 8px;
                color: #555;
            }
            input[type="text"],
            input[type="number"] {
                width: 100%;
                padding: 8px;
                margin-bottom: 20px;
                border: 1px solid #ddd;
                border-radius: 4px;
                box-sizing: border-box;
            }
            input[type="submit"] {
                width: 100%;
                padding: 10px;
                background-color: #28a745;
                color: white;
                border: none;
                border-radius: 4px;
                cursor: pointer;
            }
            input[type="submit"]:hover {
                background-color: #218838;
            }
            #Message {
                color: #4caf50;
                text-align: center;
                margin-bottom: 10px;
                font-size: 14px;
                margin-top: 10px;
            }
            a {
                text-decoration: none;
                color: blue;
                display: block;
                text-align: center;
                margin-top: 10px;
            }
            a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h2>Add Product</h2>
            <form action="MainController" method="POST">
                <label for="productID">Product ID:</label>
                <input type="text" id="productID" name="productID" required> 

                <label for="name">Name:</label>
                <input type="text" id="name" name="name" required>

                <label for="price">Price:</label>
                <input type="number" id="price" name="price" required>
                <div id="priceError">${requestScope.PRODUCT_ERROR.priceError}</div>

                <label for="quantity">Quantity:</label>
                <input type="number" id="quantity" name="quantity" required>
                <div id="quantityError">${requestScope.PRODUCT_ERROR.quantityError}</div>
                <input type="submit" name="action" value="AddProduct">
            </form>
            <div id="Message">${requestScope.MESSAGE}</div>
            <a href="MainController?action=Product">Back To Product Management</a>
        </div>
    </body>
</html>
