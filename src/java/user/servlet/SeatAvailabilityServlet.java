package user.servlet;



import connection.ConnectionDB;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.*;
import java.sql.*;
import java.util.logging.Level;
import java.util.logging.Logger;


public class SeatAvailabilityServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        PrintWriter out = response.getWriter();

        
            StringBuilder jsonResponse = new StringBuilder("{");
            
            try (Connection conn = ConnectionDB.getCon()) { 
            String query = "SELECT seatid, status FROM seat"; 
            PreparedStatement ps = conn.prepareStatement(query);
            ResultSet rs = ps.executeQuery();

            while (rs.next()) {
                String seatId = rs.getString("seatid");
                String status = rs.getString("status");

                jsonResponse.append("\"").append(seatId).append("\": \"").append(status).append("\", ");
            }

            // Remove the trailing comma and space
            if (jsonResponse.length() > 1) {
                jsonResponse.setLength(jsonResponse.length() - 2);
            }

            jsonResponse.append("}");

            // Send the response back as JSON
            out.println(jsonResponse.toString());

        } catch (SQLException e) {
            e.printStackTrace();
            out.println("{\"error\":\"Database error\"}");
        } catch (ClassNotFoundException ex) {
            Logger.getLogger(SeatAvailabilityServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }
}
