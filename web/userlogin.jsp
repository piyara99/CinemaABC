 <%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>User Login</title>
        <style>
            /* General reset */
            * {
                margin: 0;
                padding: 0;
                box-sizing: border-box;
            }

            /* Fullscreen centered layout */
            body {
                font-family: Arial, sans-serif;
                height: 100vh;
                display: flex;
                justify-content: center;
                align-items: center;
                background: linear-gradient(135deg, #6dd5ed, #2193b0);
            }

            /* Container styling */
            .login-container {
                background-color: #ffffff;
                border-radius: 10px;
                box-shadow: 0px 4px 10px rgba(0, 0, 0, 0.2);
                width: 350px;
                padding: 30px;
                text-align: center;
                animation: fadeIn 1s ease-in-out;
            }

            /* Animation for a smooth load */
            @keyframes fadeIn {
                from {
                    opacity: 0;
                    transform: scale(0.95);
                }
                to {
                    opacity: 1;
                    transform: scale(1);
                }
            }

            /* Header styling */
            .login-container h2 {
                color: #333333;
                margin-bottom: 20px;
            }

            /* Form group styling */
            .form-group {
                margin-bottom: 20px;
                text-align: left;
            }

            label {
                font-size: 14px;
                color: #555555;
            }

            input[type="text"], input[type="password"] {
                width: 100%;
                padding: 10px;
                border: 1px solid #cccccc;
                border-radius: 5px;
                margin-top: 5px;
                font-size: 14px;
            }

            /* Button styling */
            input[type="submit"] {
                width: 100%;
                padding: 10px;
                background-color: #2193b0;
                color: #ffffff;
                border: none;
                border-radius: 5px;
                font-size: 16px;
                cursor: pointer;
                transition: background-color 0.3s ease;
            }

            input[type="submit"]:hover {
                background-color: #17687b;
            }

            /* Error message styling */
            .error-message {
                color: red;
                font-size: 14px;
                margin-top: 10px;
            }
        </style>
    </head>
    <body>
        <!-- Centered Login Form -->
        <div class="login-container">
            <h2>User Login</h2>
            <form action="LoginServlet" method="POST">
                <div class="form-group">
                    <label for="email">Email</label>
                    <input type="text" id="email" name="email" placeholder="Enter your email" required />
                </div>
                <div class="form-group">
                    <label for="password">Password</label>
                    <input type="password" id="password" name="password" placeholder="Enter your password" required />
                </div>
                <input type="submit" value="Sign In" />
            </form>
            <%
                String errorMessage = (String) request.getAttribute("errorMessage");
                if (errorMessage != null) {
            %> 
                 <p class="error-message"><%= errorMessage %></p>
            <% 
                }
           %>
        </div>
    </body>
</html>
