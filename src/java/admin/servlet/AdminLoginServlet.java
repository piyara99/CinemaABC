package admin.servlet;

import connection.ConnectionDB;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class AdminLoginServlet extends HttpServlet {
private static final long serialVersionUID = 1L;

   

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Retrieve email and password from the request
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        
         boolean isValid = false;
         
         try (Connection connection = ConnectionDB.getCon()) {
            String sql = "SELECT * FROM admin WHERE email = ? AND password = ?";
            PreparedStatement preparedStatement = connection.prepareStatement(sql);
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password);

            ResultSet resultSet = preparedStatement.executeQuery();
            isValid = resultSet.next(); // If a record exists, credentials are valid
        } catch (Exception e) {
            e.printStackTrace();
            response.sendRedirect("adminlogin.html?error=Database error occurred");
            return;
        }

        
        if (isValid) {
            // Redirect to the admin panel on success
            response.sendRedirect("adminpanel.jsp");
        } else {
            // Redirect back to the login page with an error message
            response.sendRedirect("adminlogin.html?error=Invalid credentials");
        }
       
    }
}  
