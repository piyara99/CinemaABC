<%@ page import="admin.services.FeedbackService" %>
<%@ page import="java.util.*" %>
<%@ page import="com.google.gson.Gson" %>

<%
    // Get the movie ID from the query string
    String movieIdParam = request.getParameter("movieId");
    int movieId = movieIdParam != null ? Integer.parseInt(movieIdParam) : 0;
    
    // Create FeedbackService object
    FeedbackService feedbackService = new FeedbackService();
    
    // Fetch feedback data using the FeedbackService
    List<Map<String, Object>> feedbackData = feedbackService.getFeedbackData(movieId);
%>

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Customer Feedback for Movie</title>
    <script src="https://cdn.jsdelivr.net/npm/chart.js"></script>
    <style>
        body {
            font-family: Arial, sans-serif;
            padding: 20px;
            text-align: center;
        }
        .container {
            max-width: 800px;
            margin: auto;
        }
        #feedbackTable {
            width: 100%;
            margin-top: 20px;
            border-collapse: collapse;
        }
        #feedbackTable th, #feedbackTable td {
            padding: 8px;
            border: 1px solid #ddd;
        }
    </style>
</head>
<body>

    <div class="container">
        <form action="Feedback.jsp" method="get">
    <label for="movieId">Enter Movie ID:</label>
    <input type="text" name="movieId" id="movieId" required>
    <button type="submit">Submit</button>
</form>

        <h2>Customer Feedback for Movie ID: <%= movieId %></h2>
        
        <!-- Bar Chart for Feedback Visualization -->
        <canvas id="feedbackChart" width="400" height="200"></canvas>
        
        <!-- Table to display feedback details -->
        <table id="feedbackTable">
            <thead>
                <tr>
                    <th>Rating</th>
                    <th>Comments</th>
                    <th>Count</th>
                </tr>
            </thead>
            <tbody>
                <% 
                    for (Map<String, Object> feedback : feedbackData) {
                        int rating = (int) feedback.get("rating");
                        String comments = (String) feedback.get("comments");
                        int count = (int) feedback.get("count");
                %>
                <tr>
                    <td><%= rating %></td>
                    <td><%= comments %></td>
                    <td><%= count %></td>
                </tr>
                <% } %>
            </tbody>
        </table>
    </div>

    <script>
        var ctx = document.getElementById('feedbackChart').getContext('2d');
        var feedbackData = <%= new Gson().toJson(feedbackData) %>;

        var labels = [];
        var data = [];

        feedbackData.forEach(function(feedback) {
            labels.push('Rating ' + feedback.rating);
            data.push(feedback.count);
        });

        var feedbackChart = new Chart(ctx, {
            type: 'bar',
            data: {
                labels: labels,
                datasets: [{
                    label: 'Customer Ratings',
                    data: data,
                    backgroundColor: '#4caf50',
                    borderColor: '#388e3c',
                    borderWidth: 1
                }]
            },
            options: {
                scales: {
                    y: {
                        beginAtZero: true
                    }
                }
            }
        });
    </script>
</body>
</html>
