package admin.servlet;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import connection.ConnectionDB;
import java.sql.Connection;
import java.sql.SQLException;
import java.sql.PreparedStatement;
import java.util.logging.Level;
import java.util.logging.Logger;


public class AddMovieServlet extends HttpServlet {
    
      @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String title = request.getParameter("title");
        String description = request.getParameter("description");
        int duration = Integer.parseInt(request.getParameter("duration")); // Converting duration from String to int    
        String genre = request.getParameter("genre");
        String releaseDate = request.getParameter("release_date");
        String poster = request.getParameter("poster");

        try {
           
            Connection connection = ConnectionDB.getCon();
            String sql = "INSERT INTO movie (title, genre,released_date, duration, description, poster_image ) VALUES (?, ?, ?, ?, ?,?)";
            PreparedStatement ps = connection.prepareStatement(sql);
            ps.setString(1, title);
            ps.setString(2, genre);
            ps.setString(3, releaseDate);
            ps.setInt(4, duration);              
            ps.setString(5, description);
            ps.setString(6, poster);

            int rowsInserted = ps.executeUpdate();

            if (rowsInserted > 0) {
                response.sendRedirect("adminpanel.jsp?message=Movie added successfully");
            } else {
                response.sendRedirect("adminpanel.jsp?error=Failed to add movie");
            }
        } catch (NumberFormatException | SQLException e) {
            e.printStackTrace();
            response.sendRedirect("adminpanel.jsp?error=An error occurred: " + e.getMessage());
        } catch (ClassNotFoundException ex) {
              Logger.getLogger(AddMovieServlet.class.getName()).log(Level.SEVERE, null, ex);
          }
    }


 
}

 
