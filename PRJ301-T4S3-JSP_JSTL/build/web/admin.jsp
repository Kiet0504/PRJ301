<%-- 
    Document   : admin
    Created on : May 29, 2024, 2:32:37 PM
    Author     : PC
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="java.util.List"%>
<%@page import="sample.user.UserDTO" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Administrator Page</title>
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
            #Message {
                color: #4caf50;
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
            <h1>WELCOME: ${sessionScope.LOGIN_USER.fullName}</h1>
            <div class="actions">
                <form action="MainController" method="POST" class="search-form">
                    <div class="search-bar">
                        <input type="text" name="search" placeholder="Search..."/>
                        <input type="submit" name="action" value="Search"/>
                    </div>
                </form>
                <form action="MainController" method="POST" class="product-management-form">
                    <input type="submit" name="action" value="Product"/>
                </form>
            </div>
            <div id="errorMessage">${requestScope.ERROR}</div>
            <div id="Message">${requestScope.MESSAGE}</div>
            <c:if test="${requestScope.LIST_USER != null}">
                <c:if test="${not empty requestScope.LIST_USER}">
                    <table border="1">
                        <thead>
                            <tr>
                                <th>No</th>
                                <th>User ID</th>
                                <th>Full Name</th>
                                <th>Role ID</th>
                                <th>Password</th>
                                <th>Update</th>
                                <th>Deactivate</th>
                                <th>Activate</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="user" varStatus="counter" items="${requestScope.LIST_USER}">
                                <tr>
                            <form action="MainController" method="POST">
                                <td>${counter.count}</td>
                                <td>
                                    <input type="text" name="userID" value="${user.userID}" readonly=""/>
                                </td>
                                <td>
                                    <input type="text" name="fullName" value="${user.fullName}" required=""/>
                                </td>
                                <td>
                                    <input type="text" name="roleID" value="${user.roleID}" required=""/>
                                </td>
                                <td>
                                    ${user.password}
                                </td>
                                <td>
                                    <input type="submit" name="action" value="Update"/>
                                    <input type="hidden" name="search" value="${param.Search}">
                                </td>
                            </form>
                            <td>
                                <c:url var="deleteLink" value="MainController">
                                    <c:param name="action" value="Delete"></c:param>
                                    <c:param name="search" value="${param.search}"></c:param>
                                    <c:param name="userID" value="${user.userID}"></c:param>
                                </c:url>
                                <a href="${deleteLink}">Deactivate</a>
                            </td>
                            <td>
                                <c:url var="activateLink" value="MainController">
                                    <c:param name="action" value="Activate"></c:param>
                                    <c:param name="search" value="${param.search}"></c:param>
                                    <c:param name="userID" value="${user.userID}"></c:param>
                                </c:url>
                                <a href="${activateLink}">Activate</a>
                            </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </c:if>
            </c:if>
            <form action="MainController" method="POST" class="logout-form">
                <input type="submit" name="action" value="Logout"/>
            </form>
        </div>
    </body>
</html>
