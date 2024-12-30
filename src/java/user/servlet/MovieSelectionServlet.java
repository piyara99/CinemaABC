//
//import admin.model.Movie;
//import jakarta.servlet.RequestDispatcher;
//import jakarta.servlet.ServletException;
//import jakarta.servlet.http.HttpServlet;
//import jakarta.servlet.http.HttpServletRequest;
//import jakarta.servlet.http.HttpServletResponse;
//import java.io.IOException;
//import java.util.List;
//
//
//public class MovieSelectionServlet extends HttpServlet {
//    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
//        // Retrieve list of movies and their available time slots from the database
//        List<Movie> movies = MovieDAO.getAllMovies();
//        request.setAttribute("movies", movies);
//        
//        RequestDispatcher dispatcher = request.getRequestDispatcher("movieSelection.jsp");
//        dispatcher.forward(request, response);
//    }
//}
