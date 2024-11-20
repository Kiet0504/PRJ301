<%@page import="sample.product.Product"%>
<%@page import="sample.product.Cart"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>My Duyen Official</title>
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
            h1, h2 {
                color: #333;
            }
            table {
                width: 80%;
                margin: 20px 0;
                border-collapse: collapse;
                background-color: #fff;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            table th, table td {
                padding: 10px;
                text-align: left;
                border: 1px solid #ddd;
            }
            table th {
                background-color: #f8f8f8;
            }
            form {
                display: flex;
                flex-direction: column;
                align-items: flex-start;
            }
            label, input[type="text"], input[type="password"], input[type="number"], input[type="submit"], a {
                margin: 10px 0;
            }
            input[type="text"], input[type="password"], input[type="number"] {
                padding: 5px;
                width: calc(100% - 20px);
            }
            input[type="submit"] {
                padding: 10px 20px;
                background-color: #4CAF50;
                color: white;
                border: none;
                cursor: pointer;
            }
            input[type="submit"]:hover {
                background-color: #45a049;
            }
            .checkout-form {
                width: 80%;
                background-color: #fff;
                padding: 20px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
                margin-top: 20px;
            }
            a {
                text-decoration: none;
                color: white;
                background-color: #4CAF50;
                padding: 10px 20px;
                border: 1px solid #ddd;
                box-shadow: 0 0 5px rgba(0, 0, 0, 0.1);
            }
            a:hover {
                background-color: #ddd;
            }
            #errorMessage {
                color: red;
                text-align: center;
                margin-bottom: 10px;
                font-size: 14px;
            }
        </style>
    </head>
    <body>
        <h1>Your Cart</h1>
        <c:if test="${sessionScope.CART != null}">
            <c:if test="${not empty sessionScope.CART.cart}">
                <table>
                    <thead>
                        <tr>
                            <th>No</th>
                            <th>ID</th>
                            <th>Name</th>
                            <th>Quantity</th>
                            <th>Price</th>
                            <th>Total</th>
                            <th>Remove</th>
                            <th>Edit</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:set var="total" value="0" />
                        <c:forEach var="cart" varStatus="counter" items="${sessionScope.CART.cart.values()}">
                            <c:set var="total" value="${total + cart.price * cart.quantity}" />
                        <form action="MainController" method="POST">
                            <tr>
                                <td>${counter.count}</td>
                                <td>
                                    <input type="text" name="id" value="${cart.productID}" readonly/>
                                </td>
                                <td>${cart.name}</td>
                                <td>
                                    <input type="number" min="1" name="quantity" value="${cart.quantity}" required/>
                                </td>
                                <td>${cart.price}$</td>
                                <td><fmt:formatNumber value="${cart.price * cart.quantity}" type="number" minFractionDigits="2" maxFractionDigits="2" /></td>
                                <td>
                                    <c:url var="removeLink" value="MainController">
                                        <c:param name="action" value="Remove" />
                                        <c:param name="id" value="${cart.productID}" />
                                    </c:url>
                                    <a href="${removeLink}">Delete</a>
                                </td>
                                <td>
                                    <input type="submit" name="action" value="Edit"/>
                                </td>
                            </tr>
                        </form>
                    </c:forEach>
                </tbody>
            </table>
            <h2>Total: <fmt:formatNumber value="${total}" type="number" minFractionDigits="2" maxFractionDigits="2" />$</h2>
        </c:if>
    </c:if>
    <a href="MainController?action=Shopping_Page">Add more</a>
    <a href="MainController?action=History">History</a>
    <!-- Checkout Information Form -->
    <div class="checkout-form">
        <h2>Checkout Information</h2>
        <form action="MainController" method="POST">
            <input type="submit" name="action" value="Checkout"/>
            <input type="hidden" name="total" value="${total}"/>
            <input type="hidden" name="userID" value="${sessionScope.LOGIN_USER.userID}"/>
        </form>
    </div>
    <div id="errorMessage">${requestScope.ERROR}</div>
</body>
</html>
