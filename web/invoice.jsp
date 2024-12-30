<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.NumberFormat" %>

<%
    // Retrieve session data for the invoice
    String reservationId = (String) session.getAttribute("reservationId");
    String selectedSeats = (String) session.getAttribute("selectedSeats");
    String movieId = (String) session.getAttribute("movieId");
    Integer totalAmount = (Integer) session.getAttribute("totalAmount");

    // If totalAmount is null, set a default value (e.g., 0)
    if (totalAmount == null) {
        totalAmount = 0;
    }

    // Format the total amount as currency
    java.text.NumberFormat currencyFormat = java.text.DecimalFormat.getCurrencyInstance();
    String formattedTotalAmount = currencyFormat.format(totalAmount);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Invoice</title>
    <style>
        body {
            font-family: Arial, sans-serif;
        }
        .invoice-container {
            width: 80%;
            margin: 0 auto;
            padding: 20px;
            border: 1px solid #ddd;
            background-color: #f9f9f9;
        }
        .invoice-header {
            text-align: center;
            font-size: 24px;
            margin-bottom: 20px;
        }
        .invoice-table {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }
        .invoice-table th, .invoice-table td {
            padding: 10px;
            border: 1px solid #ddd;
            text-align: left;
        }
        .invoice-footer {
            text-align: right;
            margin-top: 30px;
            font-size: 18px;
        }
    </style>
</head>
<body>
    <div class="invoice-container">
        <div class="invoice-header">
            <h2>Invoice</h2>
        </div>

        <table class="invoice-table">
            <tr>
                <th>Reservation ID</th>
                <td><%= reservationId %></td>
            </tr>
            <tr>
                <th>Movie Name</th>
                <td>Coco</td>
            </tr>
            <tr>
                <th>Selected Seats</th>
                <td>D1</td>
            </tr>
            <tr>
                <th>Total Amount</th>
                <td><%= formattedTotalAmount %></td>
            </tr>
        </table>

        <div class="invoice-footer">
            <p>Thank you for your booking!</p>
        </div>
    </div>
</body>
</html>
