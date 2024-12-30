package admin.servlet;

import admin.dao.MovieDao;
import admin.model.Movie;
import connection.ConnectionDB;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.IOException;
import java.sql.SQLException;
import java.util.List;

public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false); 

        try {
            // Get the movie ID from the request parameter
            String idParam = request.getParameter("id");
            if (idParam == null || idParam.isEmpty()) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Movie ID is missing.");
                return;
            }

            int movieId;
            try {
                movieId = Integer.parseInt(idParam);
            } catch (NumberFormatException e) {
                response.sendError(HttpServletResponse.SC_BAD_REQUEST, "Invalid Movie ID format.");
                return;
            }

            // Fetch the movie details using MovieDao
            MovieDao movieDao = new MovieDao(ConnectionDB.getCon());
            Movie movie = movieDao.getMovieById(movieId);
            List<String> formats = movieDao.getFormatsByMovieId(movieId);
            List<String> languages = movieDao.getLanguagesByMovieId(movieId);

            if (movie != null) {
                // Set the movie object as a request attribute
                request.setAttribute("movie", movie);

                // Get the session user ID
                Integer sessionUserId = (session != null) ? (Integer) session.getAttribute("userId") : null;

                // Debugging: print out session userId for inspection
                System.out.println("Session User ID: " + sessionUserId);

                // If user is not logged in or sessionUserId is null, redirect to login
                if (sessionUserId == null) {
                    response.sendRedirect("login.jsp?error=invalidUser");
                    return;
                }

                // Forward to movieDetails.jsp with userId as a session attribute
                RequestDispatcher dispatcher = request.getRequestDispatcher("movieDetails.jsp");
                dispatcher.forward(request, response);
            } else {
                response.sendError(HttpServletResponse.SC_NOT_FOUND, "Movie not found.");
            }
        } catch (ClassNotFoundException | SQLException e) {
            // Log the exception (optional)
            e.printStackTrace();

            // Handle errors
            request.setAttribute("errorMessage", "An error occurred while fetching movie details.");
            RequestDispatcher dispatcher = request.getRequestDispatcher("error.jsp");
            dispatcher.forward(request, response);
        }
    }
}
