<%@page import="java.util.List"%>
<%@page import="admin.model.Movie"%>
<%@page import="admin.dao.MovieDao"%>
<%@page import="admin.model.Screen"%>
<%@ page import="java.sql.*, java.util.*" %>


<%
    // Retrieving attributes set by the servlet
    Movie movie = (Movie) request.getAttribute("movie");
    List<String> formats = (List<String>) request.getAttribute("formats");
    List<String> languages = (List<String>) request.getAttribute("languages");
    List<Screen> screenings = (List<Screen>) request.getAttribute("screenings");
    String posterImageUrl = movie.getPoster();
    

    Integer userId = (Integer) session.getAttribute("userId");


%>

<!DOCTYPE html>
<html>
    <head>
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:ital,wght@0,400..700;1,400..700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css">
       <script>
        document.addEventListener("DOMContentLoaded", function() {
            var posterImageUrl = "<%= posterImageUrl %>"; // Get the dynamic image URL from the JSP
            var heroSectionBackground = document.querySelector('.hero-section-background-image-movie');
            if (heroSectionBackground && posterImageUrl) {
                heroSectionBackground.style.backgroundImage = "url('" + posterImageUrl + "')";
            } else {
                console.error("Failed to set background image: Element or URL is missing.");
            }
        });
    </script>

    </head>
    <body>
        <div class="page-wrapper">
            <section class="hero-section">
                <div class="hero-section-background-image-movie"></div>
                <div class="movie-detail-overlay"></div>

                <div class="hero-content-container">
                    <div class="navbar">
                        <a style="text-decoration: none;" href="index.html">
                            <div class="navbar-logo-container">
                                <span class="navbar-logo-text">ABC</span>
                            </div>
                        </a>
    
                        <div class="navbar-link-container">
                            <a class="navbar-link" href="#">Search</a>
                            <a class="navbar-link" href="#">Movies</a>
                            <a class="navbar-link" href="#">Locations</a>
                            <a class="navbar-link" href="#">Contact</a>
                        </div>
    
                        <!--TODO Make Login work-->
    
                        <div class="navbar-link-container">
                            <a class="navbar-link" href="">Login</a>
                            <a class="navbar-link" href="">Sign Up</a>
                        </div>
                    </div>
                    <div class="movie-detail-hero">
                        <span style="color: var(--secondary-text-color);">
                            <h2><%= movie.getTitle() %></h2>
                            <p><%= movie.getGenre() %></p>
                        </span>
                        
                        <div class="spacer-30px"></div>
                        <div class="spacer-30px"></div>
                    </div>
                </div>
            </section>
            <section class="section">
                <div class="spacer-20px"></div>
                <div class="content-container">
                    <div class="movie-detail-flex">
                        <div>
                            <h2>Details</h2>
                            <div class="spacer-20px"></div>
                            <div class="grey-container-fill">
                                <%= movie.getDescription() %></div>
                        </div>
                        <div>
                            <h2>Available in</h2>
                            <div class="spacer-20px"></div>
                            <div class="grey-container-wrapper">
                                <div class="grey-container-centered">
                                    <img src="images/imaxlogo.svg">
                                    <img src="images/dolbylogo.svg">
                                    <img src="images/3dlogo.svg">
                                </div>
                                <div class="grey-container-centered">
                                    <p>English | Hindi (Dub) | Spanish (Sub)</p>
                                </div>
                                <div>
                        <!-- Screening buttons -->
                        <button class="screening-button" 
                                onclick="location.href='ticketbooking.jsp?movieId=<%= movie.getId() %>&time=10:00 AM&userId=<%= userId %>'">
                            10:00 AM
                        </button>
                        <button class="screening-button" 
                                onclick="location.href='ticketbooking.jsp?movieId=<%= movie.getId() %>&time=01:00 PM&userId=<%= userId %>'">
                            01:00 PM
                        </button>
                        <button class="screening-button" 
                                onclick="location.href='ticketbooking.jsp?movieId=<%= movie.getId() %>&time=04:00 PM&userId=<%= userId %>'">
                            04:00 PM
                        </button>
                    </div>

                    
                </div>
                            </div>
                        </div>
                    </div>
                    <div class="spacer-80px"></div>
                    <div class="promo-card-main">
                        <div class="promo-card-text-wrapper">
                            <h3 class="promo-card-text">Get 10% Off</h3>
                            <p class="promo-card-text">Get 10% off on every X cinema hall with the new app</p>
                        </div>
                        <div class="primary-button">Read More</div>
                        <!--TODO Make Button Functional -->
                    </div>
                </div>
                <div class="spacer-20px"></div>
            </section>
            <section class="section">
                <div class="spacer-20px"></div>
                <div class="content-container">
                    <div class="movie-detail-flex">
                        <div>
                            <h2>Screening Details</h2>
                            <div class="spacer-20px"></div>
                            <div class="grey-container-fill">
                                <img src="images/imaxlogo.svg">
                                <p>ILorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque tristique metus ac sollicitudin sodales. Quisque finibus magna in magna eleifend, non dignissim ante interdum. Donec egestas massa sed sapien interdum fringilla. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                <img src="images/dolbylogo.svg">
                                <p>ILorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque tristique metus ac sollicitudin sodales. Quisque finibus magna in magna eleifend, non dignissim ante interdum. Donec egestas massa sed sapien interdum fringilla. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                                <img src="images/3dlogo.svg">
                                <p>ILorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque tristique metus ac sollicitudin sodales. Quisque finibus magna in magna eleifend, non dignissim ante interdum. Donec egestas massa sed sapien interdum fringilla. Lorem ipsum dolor sit amet, consectetur adipiscing elit.</p>
                            </div>
                        </div>
                        <div>
                            <h2>Screening Times</h2>
                            <div class="spacer-20px"></div>
                            <div class="grey-container-wrapper">
                                <div class="grey-container-fill">
                                <img src="images/imaxlogo.svg">
                                <p>X-Y</p>
                                <img src="images/dolbylogo.svg">
                                <p>X-Y</p>
                                <img src="images/3dlogo.svg">
                                <p>X-Y</p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="spacer-20px"></div>
            </section>
            <section class="section">
                <div class="spacer-20px"></div>
                <div class="content-container">
                    <h2>Featured Movies</h2>
                    <div class="spacer-80px"></div>

                    <!--TODO Dynamic Movie cards MAKE FUNCTIONAL-->

                    <div class="movie-container-flex">
                        <div class="movie-card-container">
                            <div class="movie-card-image-container">INSERT IMAGE</div>
                            <div class="movie-card-text-container">
                                <h6>Movie name</h6>
                                <h5>Movie runtime</h5>
                            </div>
                        </div>
                        <div class="movie-card-container">
                            <div class="movie-card-image-container">INSERT IMAGE</div>
                            <div class="movie-card-text-container">
                                <h6>Movie name</h6>
                                <h5>Movie runtime</h5>
                            </div>
                        </div>
                        <div class="movie-card-container">
                            <div class="movie-card-image-container">INSERT IMAGE</div>
                            <div class="movie-card-text-container">
                                <h6>Movie name</h6>
                                <h5>Movie runtime</h5>
                            </div>
                        </div>
                    </div>

                    <!--TODO Dynamic Movie cards MAKE FUNCTIONAL-->

                    <div class="spacer-30px"></div>

                    <!--TODO Make Button Functional -->
                    <div class="secondary-button">See More</div>

                </div>
                <div class="spacer-20px"></div>
            </section>
            <div class="footer">
                <div class="content-container">
                    <div class="footer-item-flex">
                        
                        <div>
                            <img src="images/logo.png">
                            <div class="spacer-20px"></div>
                            <p>� 2023 ABC Cinema. All Rights Reserved.</p>
                        </div>
                        
                        <a class="footer-link" href="">Home</a>
                        <a class="footer-link" href="">Movies</a>
                        <a class="footer-link" href="">Locations</a>
                        <a class="footer-link" href="">Contact</a>

                    </div>
                    
                </div>
            </div>
        </div>
    </body>
</html>
