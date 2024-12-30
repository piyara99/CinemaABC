package admin.services;

import connection.ConnectionDB;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;

public class ReservationService {

    // Update reservation status
    public boolean updateReservationStatus(String reservationId, String status) {
        String sql = "UPDATE reservation SET status = ? WHERE reservationid = ?";
        
        try (Connection conn = ConnectionDB.getCon(); // Use getCon() from ConnectionDB
             PreparedStatement ps = conn.prepareStatement(sql)) {

            ps.setString(1, status);  // Set the status
            ps.setString(2, reservationId);  // Set the reservation ID

            int rowsAffected = ps.executeUpdate();
            return rowsAffected > 0; // Return true if update was successful

        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
            return false; // Return false if an error occurred
        }
    }

    public boolean insertReservation(String reservationId, String status) {
    String sql = "INSERT INTO reservation (reservationid, status) VALUES (?, ?)";
    try (Connection conn = ConnectionDB.getCon();
         PreparedStatement ps = conn.prepareStatement(sql)) {
        ps.setString(1, reservationId);  // Insert the reservation ID
        ps.setString(2, status);        // Insert the status (e.g., "Pending")
        int rowsInserted = ps.executeUpdate();
        return rowsInserted > 0;       // Return true if insertion was successful
    } catch (SQLException | ClassNotFoundException e) {
        e.printStackTrace();
        return false;                  // Return false if an error occurred
    }
}

}
