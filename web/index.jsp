<%@page import="connection.ConnectionDB"%>


<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="admin.model.Movie"%>
<%@page import="java.sql.*" %>


<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>ABC Cinema</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:ital,wght@0,400..700;1,400..700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    
</head>
<body>
    <div class="page-wrapper">
        <!-- Hero Section -->
        <section class="hero-section">
            <div class="hero-section-background-image" style="background-image: url('images/bgimg.jpg');"></div>
            <div class="hero-content-container">
                <!-- Navbar -->
                <div class="navbar">
                    <a href="index.jsp" class="navbar-logo-container">
                        <span class="navbar-logo-text">ABC</span>
                    </a>
                    <div class="navbar-link-container">
                        <a class="navbar-link" href="index.jsp">Home</a>
                        <a class="navbar-link" href="movies.jsp">Movies</a>
                        <a class="navbar-link" href="halls.jsp">Halls</a>
                        <a class="navbar-link" href="contact.jsp">Contact</a>
                         <a class="navbar-link" href="admin/adminlogin.jsp">Admin Login</a>
                         <a class="navbar-link" href="userlogin.jsp">Login</a>
                         <a class="navbar-link" href="usersignup.jsp">Sign Up</a>

                    </div>
                    <div class="navbar-search-textarea">
                        <form action="search.jsp" method="get">
                            <textarea name="search" id="search-textarea" rows="1" placeholder="Movie Name"></textarea>
                            <button type="submit">Search</button>
                        </form>
                    </div>
                </div>
                <!-- Hero Promo -->
                <div class="hero-promo-container">
                    <div class="hero-promo-card-left">
                        <h3>Get 10% Off!!!</h3>
                    </div>
                   
                </div>
            </div>
        </section>

        <!-- Featured Movies Section -->
        <section class="section">
            <div class="content-container">
                <h2>Featured Movies</h2>
                <div class="movie-container-grid">
                    <%
                        List<Movie> movies = new ArrayList<>();
                        try {
                            // Establish connection to the database
                            Connection conn = ConnectionDB.getCon();
                            String sql = "SELECT * FROM movie ORDER BY id DESC LIMIT 6"; // Query to get latest 6 movies
                            PreparedStatement ps = conn.prepareStatement(sql);
                            ResultSet rs = ps.executeQuery();

                            // Iterate over result set and populate movie objects
                            while (rs.next()) {
                                Movie movie = new Movie(
                                    rs.getInt("id"),
                                    rs.getString("title"),
                                    rs.getString("description"),
                                    rs.getString("duration"),
                                    rs.getString("genre"),
                                    rs.getString("released_date"),
                                    rs.getString("poster_image"),
                                    rs.getInt("movie_screen_id")
                                );
                                movies.add(movie);
                            }
                            conn.close();
                        } catch (Exception e) {
                            e.printStackTrace();
                        }

                        // Check if there are any movies, then display them
                        if (movies != null && !movies.isEmpty()) {
                            for (Movie movie : movies) {
                    %>
                    <a href="HomeServlet?id=<%= movie.getId() %>" class="movie-card-link">
                        <div class="movie-card-container">
                            <div class="movie-card-image-container">
                                <img src="<%= movie.getPoster() %>" alt="<%= movie.getTitle() %>" />
                            </div>
                            <div class="movie-card-text-container">
                                <h6><%= movie.getTitle() %></h6>
                                <p><%= movie.getDuration() %> mins</p>
                            </div>
                        </div>
                    </a>
                    <%
                            }
                        } else {
                    %>
                    <p>No featured movies available at the moment.</p>
                    <%
                        }
                    %>
                </div>
                <a href="movies.jsp" class="secondary-button">See More</a>
            </div>
        </section>


        <!-- Coming Soon Section -->
        <section class="section">
            <div class="content-container">
                <h2>Coming Soon</h2>
                <div class="movie-container-flex">
                    <%
                        List<Movie> comingSoonMovies = (List<Movie>) request.getAttribute("comingSoonMovies");
                        if (comingSoonMovies != null && !comingSoonMovies.isEmpty()) {
                            for (Movie movie : comingSoonMovies) {
                    %>
                    <div class="movie-card-container">
                        <div class="movie-card-image-container">
                            <img src="<%= movie.getPoster() %>" alt="<%= movie.getTitle() %>" />
                        </div>
                        <div class="movie-card-text-container">
                            <h5><%= movie.getTitle() %></h5>
                            <p>Release Date: <%= movie.getReleaseDate() %></p>
                        </div>
                    </div>
                    <%
                            }
                        } else {
                    %>
                    <p>No upcoming movies available at the moment.</p>
                    <%
                        }
                    %>
                </div>
            </div>
        </section>

        <!-- Promo Section -->
        <section class="section">
            <div class="content-container">
                <div class="promo-card-main" id="promo-card">
                    <div class="promo-card-text-wrapper">
                        <h3 class="promo-card-text">Get 10% Off</h3>
                        <p>Get 10% off on every X cinema hall with the new app.</p>
                    </div>
                    <a href="http://visa.com.lk" class="primary-button">Read More</a>
                </div>
            </div>
        </section>

        <!-- Footer -->
        <footer class="footer">
            <div class="content-container">
                <div class="footer-item-flex">
                    <div>
                        <img src="images/logo.png" alt="ABC Cinema Logo">
                        <p>© 2023 ABC Cinema. All Rights Reserved.</p>
                    </div>
                    <a class="footer-link" href="index.jsp">Home</a>
                    <a class="footer-link" href="movies.jsp">Movies</a>
                    <a class="footer-link" href="halls.jsp">Halls</a>
                    <a class="footer-link" href="contact.jsp">Contact</a>
                </div>
            </div>
        </footer>
    </div>
</body>
</html>
