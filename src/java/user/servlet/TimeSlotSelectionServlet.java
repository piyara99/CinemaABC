//package user.servlet;
//
//import java.io.IOException;
//import java.io.PrintWriter;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//
//public class TimeSlotSelectionServlet extends HttpServlet {
//
//
//    @Override
//    protected void doGet(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        
//         int movieId = Integer.parseInt(request.getParameter("movieId"));
//        List<TimeSlot> timeSlots = TimeSlotDAO.getTimeSlotsByMovieId(movieId);
//        request.setAttribute("timeSlots", timeSlots);
//
//        RequestDispatcher dispatcher = request.getRequestDispatcher("seatAvailability.jsp");
//        dispatcher.forward(request, response);
//        
//    }
//
//
//    @Override
//    protected void doPost(HttpServletRequest request, HttpServletResponse response)
//            throws ServletException, IOException {
//        processRequest(request, response);
//    }
//
//    /**
//     * Returns a short description of the servlet.
//     *
//     * @return a String containing servlet description
//     */
//    @Override
//    public String getServletInfo() {
//        return "Short description";
//    }// </editor-fold>
//
//}
