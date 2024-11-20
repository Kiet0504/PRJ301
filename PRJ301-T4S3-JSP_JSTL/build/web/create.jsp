<%-- 
    Document   : create
    Created on : Jun 12, 2024, 1:43:36 PM
    Author     : PC
--%>

<%@page import="sample.user.UserError"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <title>Create Page</title>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
    </head>
    <style>
        body {
            font-family: Arial, sans-serif;
            background-color: #f4f4f4;
            margin: 0;
            padding: 0;
        }

        h2 {
            text-align: center;
            color: #333;
        }

        form {
            background-color: #fff;
            margin: 0 auto;
            padding: 20px;
            border-radius: 10px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
            width: 300px;
        }
        input[type="text"],
        input[type="password"] {
            width: 100%;
            padding: 10px;
            margin-bottom: 10px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        input[type="submit"],
        input[type="reset"] {
            width: 100%;
            margin-bottom: 9px;
            padding: 10px;
            border: none;
            border-radius: 4px;
            background-color: #4caf50;
            color: #fff;
            cursor: pointer;
            transition: background-color 0.3s ease;
        }

        input[type="submit"]:hover,
        input[type="reset"]:hover {
            background-color: #45a049;
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
    </style>
    <body>
        <div class="container">
            <h2>Create New User</h2>
            <form action="MainController" method="POST">
                User ID:<input type="text" id="userID" name="userID" required=""/>
                Full Name:<input type="text" id="fullName" name="fullName" required="" />
                Role ID:<input type="text" id="roleID" name="roleID" value="US" readonly />
                Password:<input type="password" id="password" name="password" required="" />
                Confirm Password:<input type="password" id="confirm" name="confirm" required="" />
                <div id="errorMessage">${requestScope.USER_ERROR.error}</div>
                 <div id="errorMessage">${requestScope.USER_ERROR.userIDError}</div>
                  <div id="errorMessage">${requestScope.USER_ERROR.fullNameError}</div>
                   <div id="errorMessage">${requestScope.USER_ERROR.confirmError}</div>
                <input type="submit" name="action" value="Create">
                <input type="reset" value="Reset">
            </form>
            <a href="MainController?action=WELCOME">Login</a>
        </div>
    </body> 
</html>
