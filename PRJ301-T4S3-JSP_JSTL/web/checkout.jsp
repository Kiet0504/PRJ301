<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Order Confirmation</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f4f4f4;
                margin: 0;
                display: flex;
                justify-content: center;
                align-items: center;
                height: 100vh;
            }
            .container {
                background-color: #fff;
                padding: 20px;
                border-radius: 8px;
                box-shadow: 0px 0px 10px 0px rgba(0,0,0,0.1);
                max-width: 500px;
                width: 100%;
                text-align: center;
            }
            h1 {
                color: #333;
            }
            .error {
                color: red;
                font-weight: bold;
                margin-top: 10px;
            }
            .message {
                color: green;
                font-weight: bold;
                margin-top: 10px;
            }
            .link {
                margin-top: 20px;
            }
            .link a {
                text-decoration: none;
                color: #4caf50;
                font-weight: bold;
            }
            .link a:hover {
                text-decoration: underline;
            }
        </style>
    </head>
    <body>
        <div class="container">
            <h1>Order Confirmation</h1>
            <c:if test="${not empty ERROR_MESSAGE}">
                <p class="error"><c:out value="${ERROR_MESSAGE}"/></p>
            </c:if>
            <c:if test="${not empty MESSAGE}">
                <p class="message"><c:out value="${MESSAGE}"/></p>
            </c:if>
            <div class="link">
                <a href="MainController?action=View">View Page</a>
            </div>
        </div>
    </body>
</html>
