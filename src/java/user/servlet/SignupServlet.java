package user.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import connection.ConnectionDB; 
import java.util.logging.Level;
import java.util.logging.Logger;

public class SignupServlet extends HttpServlet {
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
        // Get form data
        String name = request.getParameter("name");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String contactNumber = request.getParameter("contact_number");

        // Validate input
        if (name == null || name.isEmpty() || email == null || email.isEmpty() ||
            password == null || password.isEmpty() || contactNumber == null || contactNumber.isEmpty()) {
            response.getWriter().println("All fields are required!");
            return;
        }

        
        String sql = "INSERT INTO customer (name, email, contact, password) VALUES (?, ?, ?, ?)";

        try (Connection connection = ConnectionDB.getCon();
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {
             
            // Set parameters for the query
            preparedStatement.setString(1, name);
            preparedStatement.setString(2, email);
            preparedStatement.setString(3, contactNumber);
            preparedStatement.setString(4, password); 

            // Execute update
            int result = preparedStatement.executeUpdate();

            // Provide feedback to the user
            if (result > 0) {
                response.getWriter().println("Signup successful!");
            } else {
                response.getWriter().println("Signup failed. Please try again.");
            }

        }  catch (SQLException e) {
    e.printStackTrace();
    response.getWriter().println("Database error: " + e.getMessage());
}

        catch (ClassNotFoundException ex) {
            Logger.getLogger(SignupServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
