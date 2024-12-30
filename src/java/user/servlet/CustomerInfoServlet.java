//package user.servlet;
//import java.sql.Connection;
//import java.sql.PreparedStatement;
//import connection.ConnectionDB;
//import jakarta.servlet.RequestDispatcher;
//import java.sql.ResultSet;
//import java.sql.SQLException; 
//import java.io.IOException;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import jakarta.servlet.http.HttpSession;
//
//
//public class CustomerInfoServlet extends HttpServlet {
//
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        
//         HttpSession session = request.getSession();
//        Integer userId = (Integer) session.getAttribute("userId"); // Retrieve userId from session
//
//
//        try (Connection conn = ConnectionDB.getCon()) {
//            String query = "SELECT name, email, contact FROM customer WHERE customerid = ?";
//            PreparedStatement ps = conn.prepareStatement(query);
//            ps.setInt(1, userId);
//
//            ResultSet rs = ps.executeQuery();
//            if (rs.next()) {
//                // Set customer details as request attributes
//                request.setAttribute("name", rs.getString("name"));
//                request.setAttribute("email", rs.getString("email"));
//                request.setAttribute("phone", rs.getString("contact"));
//            }
//        } catch (SQLException | ClassNotFoundException e) {
//            e.printStackTrace();
//            request.setAttribute("error", "Unable to fetch customer details.");
//        }
//
//        // Forward the request to the JSP page
//        RequestDispatcher dispatcher = request.getRequestDispatcher("customerForm.jsp");
//        dispatcher.forward(request, response);
//        
//        
//        
//    }
//
//   
//
//}
