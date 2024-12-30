package admin.dao;

import admin.model.Movie;
import admin.model.Screen;
import connection.ConnectionDB;
import java.sql.*;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class MovieDao {

    private final Connection connection;
    
     public MovieDao(Connection connection) {
        this.connection = connection;
    }
    
     
     
     public int addMovie(Movie movie) throws SQLException, ClassNotFoundException {
        String sql = "INSERT INTO movie (title,genre,released_date ,duration,  description, poster_image) VALUES (?, ?, ?, ?,?,?)";
        try (Connection conn = ConnectionDB.getCon(); 
             PreparedStatement pst = conn.prepareStatement(sql)) {
            pst.setString(1, movie.getTitle());
            pst.setString(2, movie.getGenre());
            pst.setString(3, movie.getReleaseDate());
            pst.setString(4, movie.getDuration());
            pst.setString(5, movie.getDescription());
            pst.setString(6, movie.getPoster());
            return pst.executeUpdate();
        }
    }

//    public int deleteMovie(int movieId) throws SQLException, ClassNotFoundException {
//        String sql = "DELETE FROM movie WHERE id = ?";
//        try (Connection conn = ConnectionDB.getCon(); 
//             PreparedStatement pst = conn.prepareStatement(sql)) {
//            pst.setInt(1, movieId);
//            return pst.executeUpdate();
//        }
//    }

    public List<Movie> getAllMovies() throws SQLException, ClassNotFoundException {
        String sql = "SELECT * FROM movie";
        List<Movie> movies = new ArrayList<>();
        try (Connection conn = ConnectionDB.getCon(); 
             PreparedStatement pst = conn.prepareStatement(sql);
             ResultSet rs = pst.executeQuery()) {
            while (rs.next()) {
                movies.add(new Movie(
                    rs.getInt("id"),
                    rs.getString("title"),
                    rs.getString("genre"),
                    rs.getString("released_date"),
                    rs.getString("description"),
                    rs.getString("duration"), 
                    rs.getString("poster_image"),
                    rs.getInt("movie_screen_id")
                ));
            }
        }
        return movies;
    }
    
    public Movie getMovieById(int movieId) {
        Movie movie = null;
        String sql = "SELECT * FROM movie WHERE id = ?";
        try (Connection conn = ConnectionDB.getCon();
             PreparedStatement ps = conn.prepareStatement(sql)) {
            ps.setInt(1, movieId);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    movie = new Movie(
                        rs.getInt("id"),
                        rs.getString("title"),
                        rs.getString("genre"),
                        rs.getString("released_date"),  
                        rs.getString("duration"),    
                        rs.getString("description"),
                        rs.getString("poster_image"),
                        rs.getInt("movie_screen_id")    
                    );
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return movie;
    }


   
    
    
     
    public List<String> getFormatsByMovieId(int movieId) {
        String query = "SELECT format_id FROM movie_formats WHERE movie_id = ?";
        List<String> formats = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, movieId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    formats.add(rs.getString("format_id"));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(MovieDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return formats;
    }

    public List<String> getLanguagesByMovieId(int movieId){
        String query = "SELECT pk_languageid FROM movielanguage WHERE movie_id = ?";
        List<String> languages = new ArrayList<>();
        try (PreparedStatement stmt = connection.prepareStatement(query)) {
            stmt.setInt(1, movieId);
            try (ResultSet rs = stmt.executeQuery()) {
                while (rs.next()) {
                    languages.add(rs.getString("pk_languageid"));
                }
            }
        } catch (SQLException ex) {
            Logger.getLogger(MovieDao.class.getName()).log(Level.SEVERE, null, ex);
        }
        return languages;
    }

   
   

}

    
