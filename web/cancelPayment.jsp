<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="admin.services.ReservationService" %>

 <%
        // Retrieve the reservationId from the request parameter
        String reservationId = request.getParameter("reservationId");
            out.println("Reservation ID: " + reservationId);

        if (reservationId != null && !reservationId.isEmpty()) {
            // Create an instance of the ReservationService class
            ReservationService reservationService = new ReservationService();

            // Attempt to update the reservation status to "Cancelled"
            boolean cancelled = reservationService.updateReservationStatus(reservationId, "Cancelled");

            if (cancelled) {
    %>
                <h3>Your payment was cancelled. Your reservation has been updated successfully.</h3>
    <%
            } else {
    %>
                <h3>There was an issue cancelling your reservation. Please try again.</h3>
    <%
            }
        } else {
    %>
            <h3>No reservation ID provided. Unable to process cancellation.</h3>
    <%
        }
    %>

<p><a href="index.jsp">Return to homepage</a></p>

