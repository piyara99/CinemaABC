<%@page import="java.util.List"%>
<%@page import="admin.model.Movie"%>
<%@page import="admin.dao.MovieDao"%>
<%@page import="admin.model.Screen"%>
<%@ page import="java.time.LocalDateTime, java.time.format.DateTimeFormatter, java.sql.Timestamp" %>
<%@ page import="connection.ConnectionDB" %>

<%@ page import="java.sql.*, java.util.*" %>


<%
    
    if (session == null || session.getAttribute("userId") == null) {
        response.sendRedirect("login.jsp");
        return;
    }

    // Retrieve the selected seats from the query parameters
    String selectedSeatsParam = request.getParameter("selectedSeats"); // Renamed to avoid conflict
    if (selectedSeatsParam != null && !selectedSeatsParam.isEmpty()) {
        // Split the seat IDs and store them in the session
        String[] seatIdsArray = selectedSeatsParam.split(","); // Use a new variable name
        session.setAttribute("selectedSeatIds", seatIdsArray);
        double total = seatIdsArray.length * 1000;
    session.setAttribute("totalAmount", total);
    
    
        try (Connection conn = ConnectionDB.getCon()) {
            String holdQuery = "UPDATE seat SET status = 'onhold' WHERE seatid = ?";
            try (PreparedStatement pstmt = conn.prepareStatement(holdQuery)) {
                for (String seatId : seatIdsArray) {
                    pstmt.setString(1, seatId.trim());
                    pstmt.addBatch();
                }
                int[] rowsAffected = pstmt.executeBatch();
                if (rowsAffected.length == 0) {
                    out.println("Some seats could not be held. Please try again.");
                    return;
                }
            }
        } catch (SQLException e) {
            e.printStackTrace();
            out.println("Error holding seats. Please try again.");
            return;
        }
    
  
        // Redirect to the checkout page
        response.sendRedirect("/app6cinema/checkout.jsp");
    } else {
        out.println("No seats selected.");
    }
%>



<!DOCTYPE html>
<html>
    <head>
        
        <link rel="preconnect" href="https://fonts.googleapis.com">
        <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
        <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:ital,wght@0,400..700;1,400..700&display=swap" rel="stylesheet">
        <link rel="stylesheet" href="css/style.css">
        <script src="js/seatselect.js"></script>
        
    </head>
    <body>
        <div class="page-wrapper">
            <section class="section" style="padding: 0;">
                <div class="content-container">
                    <div class="navbar">
                        <a style="text-decoration: none;" href="index.html">
                            <div class="navbar-logo-container">
                                <span class="navbar-logo-text">ABC</span>
                            </div>
                        </a>
    
                        <div class="navbar-link-container">
                            
                            <a class="navbar-link" href="index.html">Home</a>
                            <a class="navbar-link" href="movies.html">Movies</a>
                            <a class="navbar-link" href="halls.html">Halls</a>
                            <a class="navbar-link" href="contact.html">Contact</a>
                        </div>
                        <div class="navbar-search-textarea"><textarea name="" id=""search-textarea" rows="1">Movie Name</textarea>Search</div>
                    </div>
                </div>
                <div class="spacer-80px"></div>
                <div class="spacer-20px"></div>
                <div class="content-container">
                <div class="spacer-80px"></div>
                
                    <div class="movie-detail-flex">
                        <div>
                            <h2>Details</h2>
                            <div class="spacer-20px"></div>
                            <div class="grey-container-fill">
                                <div style="display: flex; align-items: center; gap: 20px;">
                                    <h3>Movie name</h3>
                                    <p>Action</p>
                                    <p>2H 30Min</p>
                                </div>
                                Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque tristique metus ac sollicitudin sodales. Quisque finibus magna in magna eleifend, non dignissim ante interdum. Donec egestas massa sed sapien interdum fringilla. Lorem ipsum dolor sit amet, 

                                consectetur adipiscing elit.</div>
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
                            </div>
                        </div>
                    </div>
                    <div class="spacer-20px"></div>

                    <div class="grey-container-fill-seatpage">
                        <form>
                            <div class="form-item-container">
                                <select name="screen">
                                    <option value="imax">IMAX</option>
                                    <option value="standard">Standard</option>
                                    <option value="vip">VIP</option>
                                </select>
                
                                <select name="date">
                                    <option value="2024-11-30">30th November 2024</option>
                                    <option value="2024-12-01">1st December 2024</option>
                                    <option value="2024-12-02">2nd December 2024</option>
                                </select>
                
                                <select name="time">
                                    <option value="16-18">4:00PM - 6:30PM</option>
                                    <option value="19-21">7:00PM - 9:30PM</option>
                                    <option value="22-24">10:00PM - 12:30AM</option>
                                </select>
                            </div>
                        </form>

                        <div class="ticket-booking-selection-wrapper">
                            <div class="ticket-booking-right">

                                <div class="maingrid">

                                    <div class="seat-columndisp">
                                        <p>1</p>
                                        <p>2</p>
                                        <p>3</p>
                                        <p>4</p>
                                        <p></p>
                                        <p>1</p>
                                        <p>2</p>
                                        <p>3</p>
                                        <p>4</p>
                                    </div>

                                    <div class="seat-rowdisp-left">
                                        <p>A</p>
                                        <p>C</p>
                                        <p>E</p>
                                        <p>G</p>
                                        <p>I</p>
                                        <p>K</p>
                                        <p>M</p>
                                        <p>O</p>
                                        <p>Q</p>
                                    </div>

                                    <div class="seatrowdisp-right">
                                        <p>B</p>
                                        <p>D</p>
                                        <p>F</p>
                                        <p>H</p>
                                        <p>J</p>
                                        <p>L</p>
                                        <p>N</p>
                                        <p>P</p>
                                        <p>R</p>
                                    </div>

                                    <div class="seat-screen">
                                        <h5>Screen</h5>
                                    </div>

                                    <div class="seatgrid">
                                        <div class="seat-gap"></div>
                                        <div>
                                            <input type="checkbox" name="seatIds" id="A2" onclick="UpdateTotal()">
                                        </div>
                                        <div>
                                            <input type="checkbox" name="seatIds" id="A3" onclick="UpdateTotal()">
                                        </div>
                                        <div>
                                        <input type="checkbox" name="seatIds" id="A4" onclick="UpdateTotal()">
                                        </div>

                                        <div class="seat-gap"></div>
                                        <div><input type="checkbox" name="seatIds" id="B2" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="B3" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="B4" onclick="UpdateTotal()"></div>
                                        <div class="seat-gap"></div>
                                        <div><input type="checkbox" name="seatIds" id="C1" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="C2" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="C3" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="C4" onclick="UpdateTotal()"></div>
                                        <div class="seat-gap"></div>
    
                                        <div><input type="checkbox" name="seatIds" id="D1" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="D2" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="D3" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="D4" onclick="UpdateTotal()"></div>
    
    
                                        <div><input type="checkbox" name="seatIds" id="E1" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="E2" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="E3" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="E4" onclick="UpdateTotal()"></div>
                                        <div class="seat-gap"></div>
    
                                        <div><input type="checkbox" name="seatIds" id="F1" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="F2" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="F3" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="F4" onclick="UpdateTotal()"></div>
    
                                        <div><input type="checkbox" name="seatIds" id="G1" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="G2" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="G3" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="G4" onclick="UpdateTotal()"></div>
                                        <div class="seat-gap"></div>
    
                                        <div><input type="checkbox" name="seatIds" id="H1" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="H2" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="H3" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIdsv" id="H4" onclick="UpdateTotal()"></div>
    
                                        <div><input type="checkbox" name="seatIds" id="I1" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="I2" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="I3" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="I4" onclick="UpdateTotal()"></div>
                                        <div class="seat-gap"></div>
    
                                        <div><input type="checkbox" name="seatIds" id="J1" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="J2" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="J3" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="J4" onclick="UpdateTotal()"></div>
    
                                        <div><input type="checkbox" name="seatIds" id="K1" onclick="UpdateTotal()"></div> 
                                        <div><input type="checkbox" name="seatIds" id="K2" onclick="UpdateTotal()"></div> 
                                        <div><input type="checkbox" name="seatIds" id="K3" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="K4" onclick="UpdateTotal()"></div>
                                        <div class="seat-gap"></div>
    
                                        <div><input type="checkbox" name="seatIds" id="L1" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="L2" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="L3" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="L4" onclick="UpdateTotal()"></div>
    
                                        <div><input type="checkbox" name="seatIds" id="M1" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="M2" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="M3" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="M4" onclick="UpdateTotal()"></div>
                                        <div class="seat-gap"></div>
                                        
                                        <div><input type="checkbox" name="seatIds" id="N1" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="N2" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="N3" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="N4" onclick="UpdateTotal()"></div>
                                        
                                        <div><input type="checkbox" name="seatIds" id="O1" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="O2" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="O3" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="O4" onclick="UpdateTotal()"></div>
                                        <div class="seat-gap"></div>
    
                                        <div><input type="checkbox" name="seatIds" id="P1" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="P2" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="P3" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="P4" onclick="UpdateTotal()"></div>
                                        
                                        <div class="seat-gap"></div>
                                        
                                        <div><input type="checkbox" name="seatIds" id="Q2" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="Q3" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="Q4" onclick="UpdateTotal()"></div>
                                        
                                        <div class="seat-gap"></div>
                                        
                                        <div><input type="checkbox" name="seatIds" id="R1" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="R2" onclick="UpdateTotal()"></div>
                                        <div><input type="checkbox" name="seatIds" id="R3" onclick="UpdateTotal()"></div>
                                        
                                        <div class="seat-gap"></div>
                                        
                                    </div>
                                </div>
                                <div class="seat-guide">
                                    <input type="checkbox" name="seatIds" id=""> : Available &nbsp <input type="checkbox" name="seatIds" id="disabledex"> : Not available &nbsp <input type="checkbox" name="seatIds" id="pendingex"> : on hold 
                                </div>
                            </div>

                            <div class="ticket-booking-right">
                                <h3>Selected Tickets</h3>
                                <div class="spacer-20px"></div>
                                <div class="line"></div>
                                <div class="spacer-20px"></div>
                                <script src="js/seatselect.js"></script>
                                <div class="price-wrapper">
                                </div>          
                                <div class="price-chart-item-wrapper">
                                    <h3>Snacks</h3>
                                    <div class="line"></div>
                                    <h3>Rs0</h3>
                                </div>
                                <div class="spacer-20px"></div>
                                <div class="line"></div>
                                <div class="spacer-20px"></div>
                                <div class="price-chart-item-wrapper">
                                    <h2>Total</h2>
                                    <div class="line"></div>
                                    <h2>Rs1000</h2>
                                    
                                </div>
                              
                            </div>
                            
                        </div>
                          <button onclick="proceedToCheckout()">Proceed to Checkout</button>
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
                    <div class="spacer-20px"></div>
                </div>
            </section>
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
                            <p>© 2023 ABC Cinema. All Rights Reserved.</p>
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
