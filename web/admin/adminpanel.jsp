<%@page import="admin.model.Admin"%>
<%@page import="connection.ConnectionDB"%>
<%@page import="java.sql.*" %>
<%@page import="java.util.List" %>
<%@page import="admin.model.Movie" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8"> 
    <title>Admin Panel - Movie Management</title>

    <!-- Bootstrap 5 CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/css/bootstrap.min.css" rel="stylesheet">

    <!-- FontAwesome for Icons -->
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css">

    <!-- Custom Styles -->
    <style>
        body {
            background-color: #f8f9fa; /* Light background */
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
        }

        /* Sidebar Styling */
        #sidebar {
            background-color: #ffffff; /* White background */
            height: 100vh;
            box-shadow: 2px 0 5px rgba(0, 0, 0, 0.1);
            position: fixed;
            width: 250px;
        }
        #sidebar .nav-link {
            color: #333;
            margin: 10px 0;
            transition: all 0.3s ease;
        }
        #sidebar .nav-link:hover {
            background-color: #1a3d7c;
            color: #fff;
            border-radius: 5px;
        }

        /* Main Content Area */
        #content {
            margin-left: 260px;
            padding: 20px;
        }
        .table th {
            background-color: #1a3d7c;
            color: #fff;
            text-align: center;
        }
        .table td {
            text-align: center;
        }
        .btn-primary {
            background-color: #1a3d7c;
            border: none;
        }
        .btn-primary:hover {
            background-color: #142952;
        }

        /* Header Styling */
        .header-title {
            color: #343a40;
            font-weight: 600;
        }

        /* Card Header */
        .card-header {
            background-color: #1a3d7c;
            color: #fff;
        }
    </style>
</head>
<body>
    <!-- Sidebar -->
    <div id="sidebar" class="d-flex flex-column p-3">
        <h4 class="text-center mb-4" style="color: #1a3d7c;">
            <i class="fa-solid fa-film me-2"></i> Admin Panel
        </h4>
        <ul class="nav flex-column">
            <li><a href="#" class="nav-link"><i class="fa-solid fa-dashboard me-2"></i> Dashboard</a></li>
            <li><a href="#" class="nav-link"><i class="fa-solid fa-list me-2"></i> Movie List</a></li>
            <li><a href="#" class="nav-link"><i class="fa-solid fa-plus me-2"></i> Add Movie</a></li>
            <li><a href="#" class="nav-link"><i class="fa-solid fa-users me-2"></i> Users</a></li>
            <li><a href="Feedback.jsp" class="nav-link"><i class="fa-solid fa-chart-line me-2"></i> Reports</a></li>
            <li><a href="#" class="nav-link"><i class="fa-solid fa-sign-out me-2"></i> Logout</a></li>
        </ul>
    </div>

    <!-- Content Area -->
    <div id="content">
        <!-- Page Header -->
        <div class="d-flex justify-content-between align-items-center mb-4">
            <h2 class="header-title">Movie Management</h2>
            <span class="text-secondary"><i class="fa-solid fa-calendar-day me-2"></i>14 March 2024</span>
        </div>

        <!-- Movie Table -->
        <div class="card shadow-sm mb-5">
            <div class="card-header">
                <h5 class="mb-0">Movies List</h5>
            </div>
            <div class="card-body">
                <table class="table table-bordered table-hover">
                    <thead>
                        <tr>
                            <th>ID</th>
                            <th>Title</th>
                            <th>Genre</th>
                            <th>Release Date</th>
                            <th>Duration (mins)</th>
                            <th>Description</th>
                            <th>Poster</th>
                            
                        </tr>
                    </thead>
                    <tbody>
                        <%
                            try {
                                // Get a connection to the database
                                Connection connection = ConnectionDB.getCon();
                                String sql = "SELECT * FROM movie";
                                PreparedStatement ps = connection.prepareStatement(sql);
                                ResultSet rs = ps.executeQuery();

                                // Loop through the result set and display the movie details
                                while (rs.next()) {
                                    int id = rs.getInt("id");
                                    String title = rs.getString("title");
                                    String genre = rs.getString("genre");
                                    String releaseDate = rs.getString("released_date");
                                    int duration = rs.getInt("duration");
                                    String description = rs.getString("description");
                                    String poster = rs.getString("poster_image");

                        %>
                        <tr>
                            <td><%= id %></td>
                            <td><%= title %></td>
                            <td><%= genre %></td>
                            <td><%= releaseDate %></td>
                            <td><%= duration %></td>
                            <td><%= description %></td>
                            <td><%= poster %></td>
                            
                        </tr>
                        <%
                                }
                            } catch (Exception e) {
                                out.println("<tr><td colspan='6' class='text-danger'>Error: " + e.getMessage() + "</td></tr>");
                            }
                        %>
                    </tbody>
                </table>
            </div>
        </div>

        <!-- Add Movie Form -->
        <div class="card shadow-sm" style="width: 50%; margin: 0 auto;">
            <div class="card-header" style="background-color: #1a3d7c; color: #ffffff;">
                <h5 class="mb-0">Add New Movie</h5>
            </div>
            <div class="card-body">
                <form action="AddMovieServlet" method="POST">
                    <div class="mb-3">
                        <label for="title" class="form-label">Title</label>
                        <input type="text" id="title" name="title" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="description" class="form-label">Description</label>
                        <textarea id="description" name="description" class="form-control" rows="3" required></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="duration" class="form-label">Duration (minutes)</label>
                        <input type="number" id="duration" name="duration" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="genre" class="form-label">Genre</label>
                        <input type="text" id="genre" name="genre" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="release_date" class="form-label">Release Date</label>
                        <input type="date" id="release_date" name="release_date" class="form-control" required>
                    </div>
                    <div class="mb-3">
                        <label for="poster_image" class="form-label">Poster Image</label>
                        <input type="text" id="poster_image" name="poster_image" class="form-control" required>
                    </div>
                    <div class="text-center">
                        <button type="submit" class="btn" style="background-color: #1a3d7c; color: #ffffff;">Add Movie</button>
                    </div>
                    
                </form>
            </div>
        </div>
    </div>

    <!-- Bootstrap JS -->
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
