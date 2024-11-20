<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="sample.product.Product" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
    <head>
        <title>Product Management</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                margin: 0;
                padding: 0;
                background-color: #f4f4f4;
            }
            .container {
                width: 80%;
                margin: 20px auto;
                padding: 20px;
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            h1 {
                color: #333;
                text-align: center;
            }
            .header {
                display: flex;
                justify-content: space-between;
                align-items: center;
                margin-bottom: 20px;
            }
            .header form {
                display: flex;
                align-items: center;
                flex-grow: 1; 
                justify-content: space-between; 
            }
            .search-bar {
                display: flex;
                align-items: center;
                width: 200%;
            }
            form {
                margin-bottom: 20px;
            }
            input[type="text"], input[type="password"] {
                width: calc(100% - 22px);
                padding: 10px;
                margin: 5px 0;
                border: 1px solid #ccc;
                border-radius: 5px;
            }
            input[type="submit"] {
                padding: 10px 20px;
                background-color: #28a745;
                color: #fff;
                border: none;
                border-radius: 5px;
                cursor: pointer;
            }
            input[type="submit"]:hover {
                background-color: #218838;
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin: 20px 0;
            }
            th, td {
                padding: 12px;
                text-align: left;
                border-bottom: 1px solid #ddd;
            }
            th {
                background-color: #f8f9fa;
            }
            tr:hover {
                background-color: #f1f1f1;
            }
            #errorMessage {
                color: red;
                text-align: center;
                margin-bottom: 10px;
                font-size: 14px;
            }
            a {
                text-decoration: none;
                color: #4caf50;
                display: block;
                text-align: center;
                margin-top: 10px;
            }
            a:hover {
                text-decoration: underline;
            }
            .actions {
                display: flex;
                align-items: center;
                justify-content: space-between;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Product List</h1>
            <div class="actions">
                <form action="MainController" method="POST" class="search-form">
                    <div class="search-bar">
                        <input type="text" name="searchProduct" placeholder="Search..."/>
                        <input type="submit" name="action" value="SearchProduct"/>
                    </div>
                </form>
                <form action="MainController" method="POST" class="add-form">
                    <input type="submit" name="action" value="AddProduct"/>
                </form>
            </div>
            <div id="errorMessage">${requestScope.ERROR}</div>
            <c:if test="${not empty requestScope.PRODUCT_LIST}">
                <table border="1">
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>Product ID</th>
                            <th>Name</th>
                            <th>Price</th>
                            <th>Quantity</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:if test="${not empty PRODUCT_LIST}">
                            <c:forEach var="product" items="${PRODUCT_LIST}" varStatus="counter">
                                <tr>
                            <form action="MainController" method="POST">
                                <td>${counter.count}</td>
                                <td>
                                    <input type="text" name="productID" value="${product.productID}" readonly=""/>
                                </td>
                                <td>
                                    <input type="text" name="name" value="${product.name}" readonly=""/>
                                </td>
                                <td>
                                    <input type="text" name="price" value="${product.price}" readonly=""/>
                                </td>
                                <td>
                                    <input type="text" name="quantity" value="${product.quantity}" readonly=""/>
                                </td>
                                </tr>
                            </c:forEach>
                            </tbody>
                    </table>
                </c:if>
            </c:if>
        </div>
    </body>
</html>
