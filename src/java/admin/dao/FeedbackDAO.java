package admin.dao;

import java.sql.*;
import java.util.*;
import connection.ConnectionDB;

public class FeedbackDAO {
    
    // Fetch Feedback Data by Movie ID
    public List<Map<String, Object>> getFeedbackData(int movieId) {
        List<Map<String, Object>> feedbackList = new ArrayList<>();
        
        // Define the SQL query
        String sql = "SELECT rating, COUNT(*) AS count, GROUP_CONCAT(comments) AS comments " + 
                     "FROM feedback WHERE movie_id = ? GROUP BY rating";
        
        try (Connection conn = ConnectionDB.getCon(); 
             PreparedStatement ps = conn.prepareStatement(sql)) {
            
            // Set the movieId parameter
            ps.setInt(1, movieId);
            
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    Map<String, Object> feedbackData = new HashMap<>();
                    feedbackData.put("rating", rs.getInt("rating"));
                    feedbackData.put("count", rs.getInt("count"));
                    feedbackData.put("comments", rs.getString("comments"));
                    feedbackList.add(feedbackData);
                }
            }
        } catch (SQLException | ClassNotFoundException e) {
            e.printStackTrace();
        }
        
        return feedbackList;
    }
}

