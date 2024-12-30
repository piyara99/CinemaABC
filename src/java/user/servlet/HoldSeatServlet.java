package user.servlet;

import connection.ConnectionDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.logging.Level;
import java.util.logging.Logger;


public class HoldSeatServlet extends HttpServlet {


private static final Logger logger = Logger.getLogger(HoldSeatServlet.class.getName());


    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        
       HttpSession session = request.getSession();
        String seatIds = request.getParameter("seatIds");

        if (seatIds != null && !seatIds.isEmpty()) {
            // Store seat IDs in session
            session.setAttribute("selectedSeatIds", seatIds.split(","));

            // Send success response
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": true, \"message\": \"Seats held successfully.\"}");
        } else {
            // Send error response
            response.setContentType("application/json");
            response.getWriter().write("{\"success\": false, \"message\": \"No seats selected.\"}");
        }
    }
}


