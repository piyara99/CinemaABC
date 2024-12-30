<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Error Page</title>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f4f4f9;
            color: #333;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
        }
        .error-container {
            text-align: center;
            padding: 20px;
            background-color: #fff;
            border: 1px solid #ccc;
            border-radius: 8px;
            box-shadow: 0 2px 10px rgba(0, 0, 0, 0.1);
        }
        .error-container h1 {
            color: #d9534f;
            font-size: 24px;
            margin-bottom: 20px;
        }
        .error-container p {
            font-size: 16px;
            margin-bottom: 10px;
        }
        .error-container a {
            text-decoration: none;
            color: #007bff;
            font-weight: bold;
        }
        .error-container a:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>
    
     <div class="error-container">
        <h1>Oops! An error occurred.</h1>
        <p>
            <b>Error Message:</b> 
            <%= (request.getAttribute("errorMessage") != null) 
                ? request.getAttribute("errorMessage") 
                : "An unexpected error occurred." %>
        </p>

        <h2>Debug Information</h2>
        <p>
            <b>Request URI:</b> <%= request.getRequestURI() %><br>
            <b>Servlet Path:</b> <%= request.getServletPath() %><br>
            <b>Query String:</b> <%= request.getQueryString() != null ? request.getQueryString() : "N/A" %><br>
            <b>HTTP Method:</b> <%= request.getMethod() %><br>
        </p>

        <h2>Exception Details</h2>
        <p>
            <b>Exception Type:</b> <%= request.getAttribute("javax.servlet.error.exception_type") %><br>
            <b>Exception:</b> <%= request.getAttribute("javax.servlet.error.exception") %><br>
            <b>Stack Trace:</b>
        </p>
        <p>
            <%= (request.getAttribute("javax.servlet.error.exception") != null) 
                ? ((Throwable) request.getAttribute("javax.servlet.error.exception")).getMessage() 
                : "No exception available." %>
        </p>

        <p>
            <a href="home.jsp">Go back to Home</a>
        </p>
    </div>
   
</body>
</html>
