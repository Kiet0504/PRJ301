<%@page import="java.util.Map"%>
<%@page import="java.util.List"%>
<%@page import="sample.product.Product"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Official</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                padding: 0;
                display: flex;
                flex-direction: column;
                align-items: center;
            }
            h1 {
                color: #333;
            }
            .container {
                width: 80%;
                background-color: #fff;
                padding: 20px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                margin-top: 20px;
            }
            .product {
                display: flex;
                align-items: center;
                margin-bottom: 20px;
            }
            .product-info {
                flex-grow: 1;
            }
            .product-actions {
                display: flex;
                flex-direction: column;
                align-items: flex-start;
            }
            form {
                display: flex;
                flex-direction: column;
                align-items: flex-start;
            }
            .search-bar {
                display: flex;
                align-items: center;
                justify-content: space-between;
                width: 100%;
                margin-bottom: 20px;
            }
            .search-bar input[type="text"] {
                padding: 5px;
                flex: 1;
                margin-right: 10px;
            }
            .search-bar input[type="submit"] {
                padding: 10px 20px;
                background-color: #4CAF50;
                color: white;
                border: none;
                cursor: pointer;
                margin-right: 10px;
            }
            .search-bar input[type="submit"]:hover {
                background-color: #45a049;
            }
            .message {
                margin-top: 20px;
                padding: 10px;
                color: limegreen;
            }
            .button-group {
                display: flex;
                gap: 10px;
            }
            .quantity-select {
                display: flex;
                align-items: center;
                margin-top: 10px;
            }
            .quantity-select label {
                margin-right: 10px;
            }
            .quantity-select select {
                padding: 5px;
                margin-right: 10px;
            }
            .quantity-select input[type="submit"] {
                padding: 10px 20px;
                background-color: #4CAF50;
                color: white;
                border: none;
                cursor: pointer;
            }
            .quantity-select input[type="submit"]:hover {
                background-color: #45a049;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>WELCOME TO MY STORE</h1>
            <form action="MainController" method="POST">
                <div class="search-bar">
                    <input type="text" name="searchProduct" placeholder="Search..."/>
                    <div class="button-group">
                        <input type="submit" name="action" value="Find"/>
                        <input type="submit" name="action" value="View"/>
                        <input type="submit" name="action" value="Logout"/>
                    </div>
                </div>
            </form>
            <c:if test="${not empty MESSAGE}">
                <div class="message">${MESSAGE}</div>
            </c:if>
            <c:if test="${not empty PRODUCT_LIST}">
                <c:forEach var="product2" items="${PRODUCT_LIST}">
                    <div class="product">
                        <div class="product-info">
                            <strong>${product2.name}</strong><br>
                            Price: ${product2.price}$
                        </div>
                        <div class="product-actions">
                            <form action="MainController" method="POST">
                                <div class="quantity-select">
                                    <label for="cmbQuantity-${product2.productID}">Quantity:</label>
                                    <select name="cmbQuantity" id="cmbQuantity-${product2.productID}">
                                        <c:forEach var="i" begin="1" end="5">
                                            <option value="${i}">${i}</option>
                                        </c:forEach>
                                        <option value="10">10</option>
                                        <option value="50">50</option>
                                    </select>
                                    <input type="hidden" name="cmbProduct" value="${product2.productID}-${product2.name}-${product2.price}">
                                    <input type="submit" name="action" value="Add"/>
                                </div>
                            </form>
                        </div>
                    </div>
                </c:forEach>
            </c:if>            
        </div>
    </body>
</html>
