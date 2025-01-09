<%@ page language="java" contentType="text/html; charset=ISO-8859-1" pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List, java.util.Map"%>
<jsp:include page="common/leftPanel.jsp" />
<jsp:include page="common/header.jsp" />

<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="ISO-8859-1">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Your Bids</title>
    <link rel="stylesheet" href="path/to/your/css/styles.css"> <!-- Update with actual stylesheet path -->
</head>
<body>
<div class="container-fluid pt-4 px-4">
    <div class="row g-4">
        <div class="col-sm-12 col-xl-6">
            <div class="bg-light rounded h-100 p-4">
                <h1 class="mb-4">Your Bids</h1>

                <% 
                // Display success or error message if present
                String message = (String) request.getAttribute("message");
                String messageType = (String) request.getAttribute("messageType");
                if (message != null) { 
                %>
                <div class="<%= "success".equals(messageType) ? "message-success" : "message-error" %>">
                    <%= message %>
                </div>
                <% 
                } 
                %>

                <table class="table table-bordered">
                    <thead>
                        <tr>
                            <th scope="col">Job Title</th>
                            <th scope="col">Bid Amount</th>
                            <th scope="col">Bid Time</th>
                            <th scope="col">Message</th>
                        </tr>
                    </thead>
                    <tbody>
                        <%
                        // Retrieve the list of bids
                        List<Map<String, Object>> jobList = (List<Map<String, Object>>) request.getAttribute("job_list");
                        if (jobList != null && !jobList.isEmpty()) {
                            for (Map<String, Object> job : jobList) {
                        %>
                        <tr>
                            <td><%= job.get("job_title") %></td>
                            <td><%= job.get("bid_amount") %></td>
                            <td><%= job.get("bid_time") != null ? job.get("bid_time").toString() : "N/A" %></td>
                            <td><%= job.get("message") != null ? job.get("message") : "N/A" %></td>
                        </tr>
                        <%
                            }
                        } else {
                        %>
                        <tr>
                            <td colspan="4" class="text-center">No bids found.</td>
                        </tr>
                        <%
                        }
                        %>
                    </tbody>
                </table>
                <a href="JobList_Servlet" class="btn btn-primary">Back to Job List</a>
            </div>
        </div>
    </div>
</div>
<jsp:include page="common/footer.jsp" />
</body>
</html>
