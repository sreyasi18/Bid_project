<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>

<%@ page import="java.util.*"%>
<%
    request.setAttribute("activePage", "postJob");
%>
<jsp:include page="common/leftPanel.jsp" />
<jsp:include page="common/header.jsp" />
<%
   // Check if the user is already logged in
   
   //retrieves the current session without creating a new one. null is returned if no session exists.
   HttpSession sessionObj = request.getSession(false);
   out.println(sessionObj.getAttribute("is_loggedin"));
   if (sessionObj != null && sessionObj.getAttribute("is_loggedin") == null) {
   	
       // User is already logged in, redirect to the dashboard
       response.sendRedirect("login.jsp");
       return; // Stop further execution of the JSP
   }
%>
<%
Map<String, Object> job = null;
// Retrieve job list from the request attributes
List<Map<String, Object>> jobList = (List<Map<String, Object>>) request.getAttribute("jobList");
if (jobList != null && !jobList.isEmpty()) {
    job = jobList.get(0); // Assuming there's only one job in the list
}
%>

<!-- Form Start -->
<div class="container-fluid pt-4 px-4">
	<div class="row g-4">
		<div class="col-sm-12 ">
			<div class="bg-light rounded h-100 p-4">
				<form action="PostJobServlet" method="post">
					<input type="hidden" name="job_id"
						value="<%= (job != null) ? job.get("job_id") : "" %>">
					<div class="mb-3">
						<label for="jobTitle" class="form-label">Job Title:</label> <input
							type="text" class="form-control" id="jobTitle" name="job_title"
							value="<%= (job != null) ? job.get("job_title") : "" %>">
					</div>
					<div class="mb-3">
						<label for="description" class="form-label">Description:</label>
						<textarea class="form-control" id="description" name="description"><%= (job != null) ? job.get("description") : "" %></textarea>
					</div>
					<div class="mb-3">
						<label for="duration" class="form-label">Duration:</label> <input
							type="text" class="form-control" id="duration" name="duration"
							value="<%= (job != null) ? job.get("duration") : "" %>">
					</div>
					<div class="mb-3">
						<label for="timeline" class="form-label">Timeline:</label> <input
							type="date" class="form-control" id="timeline" name="timeline"
							value="<%= (job != null) ? job.get("timeline") : "" %>">
					</div>
					<div class="mb-3">
						<label for="jobEndsBefore" class="form-label">Job Ends
							Before:</label> <input type="date" class="form-control"
							id="jobEndsBefore" name="job_ends_before"
							value="<%= (job != null) ? job.get("job_ends_before") : "" %>">
					</div>
					<div class="mb-3">
						<label for="maxCost" class="form-label">Max Cost:</label> <input
							type="text" class="form-control" id="maxCost" name="max_cost"
							value="<%= (job != null) ? job.get("max_cost") : "" %>">
					</div>
					<div class="mb-3">
						<label for="minCost" class="form-label">Min Cost:</label> <input
							type="text" class="form-control" id="minCost" name="min_cost"
							value="<%= (job != null) ? job.get("min_cost") : "" %>">
					</div>
					<div class="mb-3">
						<label for="bidEndOn" class="form-label">Bid Ends On:</label> <input
							type="date" class="form-control" id="bidEndOn" name="bid_end_on"
							value="<%= (job != null) ? job.get("bid_end_on") : "" %>">
					</div>
					<div class="mb-3">
						<label for="location" class="form-label">Location:</label> <input
							type="text" class="form-control" id="location" name="location"
							value="<%= (job != null) ? job.get("location") : "" %>">
					</div>
					<button type="submit" class="btn btn-primary">Submit</button>
				</form>


			</div>
		</div>
	</div>
</div>


<%
        String message = (String) request.getAttribute("message");
        String messageType = (String) request.getAttribute("messageType");
        if (message != null) {
    %>
<div
	class="<%= "success".equals(messageType) ? "message-success" : "message-error" %>">
	<%= message %>
</div>
<%
        }
    %>

<jsp:include page="common/footer.jsp" />
