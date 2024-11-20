<%-- 
    Document   : user
    Created on : May 29, 2024, 2:30:40 PM
    Author     : PC
--%>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page import="sample.user.UserDTO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Page</title>
    </head>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .container {
            background-color: #fff;
            padding: 20px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            border-radius: 10px;
            width: 300px;
            text-align: center;
        }
        h1 {
            color: #333;
            margin-bottom: 20px;
        }
        .user-info {
            margin: 10px 0;
            font-size: 16px;
        }
        .user-info span {
            font-weight: bold;
        }
        .logout-button {
            margin-top: 20px;
        }
        .logout-button input {
            padding: 10px 20px;
            background-color: #dc3545;
            color: #fff;
            border: none;
            border-radius: 5px;
            cursor: pointer;
        }
        .logout-button input:hover {
            background-color: #c82333;
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
    </style>
    <body>
        <div class="container">
            <h1>Login User's Information</h1>
            <c:if test="${sessionScope.LOGIN_USER == null || sessionScope.LOGIN_USER.roleID ne 'US'}">
                <c:redirect url="login.html"></c:redirect>
            </c:if>
            <div class="user-info">
                <span>User ID:</span> ${sessionScope.LOGIN_USER.userID}
            </div>
            <div class="user-info">
                <span>Full Name:</span>${sessionScope.LOGIN_USER.fullName}
            </div>
            <div class="user-info">
                <span>Role ID:</span> ${sessionScope.LOGIN_USER.roleID}
            </div>
            <div class="user-info">
                <span>Password:</span> ${sessionScope.LOGIN_USER.password}
            </div>
            <div class="logout-button">
                <form action="MainController" method="POST">
                    <input type="submit" name="action" value="Logout"/>
                    <a href="MainController?action=Shopping_Page">My Duyen Luxury Store</a>
                </form>
            </div>
        </div>
    </body>
</html>
