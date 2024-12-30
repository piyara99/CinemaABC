package user.servlet;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import connection.ConnectionDB; // Ensure this imports your database connection utility class
import jakarta.servlet.http.HttpSession;
import java.util.logging.Level;
import java.util.logging.Logger;

public class LoginServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        // Get username and password from the request
        String email = request.getParameter("email");
        String password = request.getParameter("password");

        // Validate input
        if (email == null || email.isEmpty() || password == null || password.isEmpty()) {
            response.getWriter().println("Email and password are required!");
            return;
        }

        // SQL query to validate login
        String sql = "SELECT * FROM customer WHERE email = ? AND password = ?";

        try (Connection connection = ConnectionDB.getCon(); // Replace `getCon` with your method
             PreparedStatement preparedStatement = connection.prepareStatement(sql)) {

            // Set parameters for the query
            preparedStatement.setString(1, email);
            preparedStatement.setString(2, password); // Use hashed passwords in a real application

            // Execute query
            ResultSet resultSet = preparedStatement.executeQuery();

            // Process the result
            if (resultSet.next()) {
                
                int userId = resultSet.getInt("customerid");
                String username = resultSet.getString("name");
                String phone = resultSet.getString("contact");
                // Create a session and store user ID in it
                HttpSession session = request.getSession();
                session.setAttribute("userId", userId);
                session.setAttribute("username", username);
                session.setAttribute("email", email);
                session.setAttribute("phone", phone);

                response.sendRedirect("index.jsp?");
                response.getWriter().println("Login successful!");
            } else {
                response.getWriter().println("Invalid username or password.");
            }

        } catch (SQLException e) {
            // Log and send a user-friendly message
            e.printStackTrace();
            response.getWriter().println("An error occurred while processing your login. Please try again.");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(LoginServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
