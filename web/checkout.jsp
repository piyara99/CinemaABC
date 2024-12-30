<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
 <%@ page import="java.sql.*, java.util.*" %>
 <%@ page import= "connection.ConnectionDB, user.model.Customer" %>
 <%@ page import= "java.util.UUID" %>

 
 <%
    // Retrieve parameters from query string
    String selectedSeats = request.getParameter("selectedSeats");
    String movieId = request.getParameter("movieId");
    
    
String reservationId = UUID.randomUUID().toString();
session.setAttribute("reservationId", reservationId); // Store in session

 admin.services.ReservationService reservationService = new admin.services.ReservationService();
    boolean inserted = reservationService.insertReservation(reservationId, "Pending");

//    String userId = request.getParameter("userId");

    // Retrieve customer details from session
    String name = (String) session.getAttribute("username");
    String email = (String) session.getAttribute("email");
    String phone = (String) session.getAttribute("phone");

    // Split selectedSeats into an array for display
    String[] seatArray = selectedSeats != null ? selectedSeats.split(",") : new String[0];
    int Amount = seatArray.length*1000;
    int totalAmount = Amount+544;
    session.setAttribute("totalAmount", totalAmount);
    
 
    
%>

<html>
<head>
    <title>Reservation Summary</title>
    <link href="https://fonts.googleapis.com/css2?family=Instrument+Sans:ital,wght@0,400..700;1,400..700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="css/style.css">
    <script src="js/seatselect.js"></script>
    <style>
            :root {
                --primary-color: #000000;
                --secondary-color: #194198;
                --background-color: #ffffff;
                --secondary-background-color: #ECECEC;
                --text-color: #000000;
                --secondary-text-color: #ffffff;
            }

            body {
                margin: 0;
                font-family: "Instrument Sans", sans-serif;
                color: var(--text-color);
                background-color: var(--background-color);
            }

           

            .navbar-logo-container {
                font-size: 32px;
                font-weight: 700;
                color: #FFF;
            }

            .navbar-link-container {
                display: flex;
                gap: 20px;
            }

            .navbar-link {
                color: #FFF;
                text-decoration: none;
                font-size: 16px;
                font-weight: 500;
            }

            /* Page content styles */
            .content-container {
                padding: 20px;
                max-width: 1160px;
                margin: 0 auto;
            }

            h2 {
                text-align: center;
                margin-bottom: 30px;
                font-size: 28px;
                color: var(--primary-color);
            }

            /* Reservation and checkout summary styles */
            .reservation-summary {
                background-color: var(--secondary-background-color);
                padding: 20px;
                border-radius: 8px;
                margin-bottom: 30px;
            }

            .reservation-summary table {
                width: 100%;
                border-collapse: collapse;
                margin-bottom: 10px;
            }

            .reservation-summary td {
                padding: 8px;
                border: 1px solid #ddd;
                text-align: left;
            }

            .reservation-summary .total {
                font-weight: bold;
                background-color: #f1f1f1;
            }

            /* Payment Section */
            .payment-section {
                background-color: var(--secondary-background-color);
                padding: 20px;
                border-radius: 8px;
            }

            .payment-section h2 {
                margin-bottom: 20px;
                font-size: 24px;
                color: var(--primary-color);
            }

            .payment-buttons {
                display: flex;
                justify-content: space-between;
                margin-bottom: 20px;
            }

            .payment-buttons button {
                padding: 10px 20px;
                border: none;
                border-radius: 5px;
                cursor: pointer;
                background-color: var(--primary-color);
                color: #FFF;
                font-size: 16px;
                font-weight: 500;
                width: 48%;
            }

            .input-section {
                margin-bottom: 20px;
            }

            .input-section label {
                display: block;
                margin-bottom: 5px;
                font-size: 16px;
            }

            .input-section input {
                display: block;
                width: 100%;
                padding: 8px;
                margin-bottom: 10px;
                border: 1px solid #ccc;
                border-radius: 5px;
                font-size: 16px;
            }

            /* Terms */
            .terms {
                display: flex;
                align-items: center;
                margin-top: 10px;
            }

            .terms input {
                margin-right: 5px;
            }
        </style>
</head>
<body>
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
        
        <div class="reservation-summary">
            <h2>Reservation Summary</h2>
            <table>
                <tr>
                    <td>Movie:</td>
                    <td><b id="movie-name"><%= movieId != null ? movieId : "N/A" %></b></td>
                </tr>
                <tr>
                    <td>Seats Selected (x <span id="num-seats"> <% for (String seat : seatArray) { %>
                    <span><%= seat %></span>
                <% } %></span>):</td>
                    <td><span id="ticket-price">LKR <%= seatArray.length * 1000 %></span></td>
                </tr>
                <tr>
                    <td>VAT Included:</td>
                    <td><span id="vat-included">LKR 544</span></td>
                </tr>
                <tr class="total">
                    <td>Total:</td>
                    <td><span id="total-amount">LKR <%= totalAmount %> </span></td>
                </tr>
            </table>
               <form action="cancelPayment.jsp" method="post">
    <input type="hidden" name="reservationId" value="<%= session.getAttribute("reservationId") %>" />
    <input type="submit" value="Cancel Payment" />
</form>


        </div>
                    
                     <div class="payment-section">
            <h2>SELECT YOUR PAYMENT MODE</h2>
            <div class="payment-buttons">
                  <div id="paypal-button-container"></div>
        <p id="result-message"></p>

        
        <!-- Initialize the JS-SDK -->
        <div id="content" class="hide">
            <div class="ms-card ms-fill">
              <div class="ms-card-content">              
                 <img src="https://media.istockphoto.com/id/1295114854/photo/empty-red-armchairs-of-a-theater-ready-for-a-show.jpg?s=612x612&w=0&k=20&c=0rDtwzMmLbqe_8GuGw2dpjkD0MsXGywJmdmg0jDbMxQ=" style="width:400px">
              <script src="https://www.paypal.com/sdk/js?client-id=AUvwKjTPAfcV_ajm6N3UsopVgAtLRWRgMmwv3xFoH9cVdzqi9WxPtK9Rug9ukj-CFdxz-TGHuLFB9ANB&components=buttons"></script>
<div id="paypal-button-container"></div>
<script>
paypal.Buttons({
    createOrder: function(data, actions) {
        return actions.order.create({
            purchase_units: [{
                amount: {
                    value: '100.00'  // Payment amount
                }
            }]
        });
    },
    onApprove: function(data, actions) {
        return actions.order.capture().then(function(details) {
            alert('Transaction completed by ' + details.payer.name.given_name);  // Show buyer's name
            console.log(details); 
             window.location.href = `invoice.jsp?`;
            
            
       
        });
    }
}).render('#paypal-button-container');  // Render the PayPal button inside the specified container
</script>

              </div>
            </div>
            <div id="payment_options"></div>
            
          </div>
        
        <div>
        <h3>Customer Information</h3>
        <form id="customer-form">
            <label for="name">Name:</label>
            <input type="text" id="name" name="name" value="<%= name %>" readonly><br>

            <label for="email">Email:</label>
            <input type="email" id="email" name="email" value="<%= email %>" readonly><br>

            <label for="phone">Phone:</label>
            <input type="text" id="phone" name="phone" value="<%= phone %>" readonly><br>
        </form>
        </div>
        </div>

       
    </div>
</body>
</html>
