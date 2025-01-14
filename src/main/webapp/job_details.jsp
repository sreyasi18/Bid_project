<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%><%@ page
	import="java.util.List, java.util.Map"%>
<jsp:include page="common/leftPanel.jsp" />
<jsp:include page="common/header.jsp" />

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Job Details</title>
</head>
<body>
	<div class="container-fluid pt-4 px-4">
		<div class="bg-light text-center rounded p-4">
			<div class="d-flex align-items-center justify-content-between mb-4">
			</div>
		</div>
		<div class="table-responsive">
			<div class="d-flex align-items-center border-bottom py-3">
				<div class="w-100 ms-3">
					<div class="d-flex w-100 justify-content-between">
						<div align="center">
							<a href="LogoutServlet">Logout</a> <a href="postJob.jsp">Post
								a Job</a> <a href="dashboard.jsp">Dashboard</a> <a
								href="JobList_Servlet">Back to Job List</a>
						</div>

						<%
	String message = (String) request.getAttribute("message");
	String messageType = (String) request.getAttribute("messageType");
	if (message != null) {
	%>
						<div
							class="<%="success".equals(messageType) ? "message-success" : "message-error"%>">
							<%=message%>
						</div>
						<%
	}

	Map<String, Object> jobDetails = (Map<String, Object>) request.getAttribute("job_details");
	if (jobDetails != null) {
	%>
						<div align="center">
							<h1>Job Details</h1>
							<p>
								<strong>Job Title:</strong>
								<%=jobDetails.getOrDefault("job_title","N/A")%></p>
							<p>
								<strong>Description:</strong>
								<%=jobDetails.getOrDefault("description","N/A")%></p>
							<p>
								<strong>Created At:</strong>
								<%=jobDetails.getOrDefault("created_at","N/A")%></p>
							<p>
								<strong>Status:</strong>
								<%=jobDetails.getOrDefault("status","N/A")%></p>

							<%
			int userId = (int) session.getAttribute("user_id");
			int createdBy = (int) jobDetails.get("created_by");
			//int jobId =(int)jobDetails.get("job_id");
			%>


							<%
			
		
		if (userId == createdBy) {  // Corrected to use '=='
		%>
							<table>
								<tr>
									<th>Bidder</th>
									<th>Bid Amount</th>
									<th>Added On</th>
									<th>Action</th>
								</tr>

								<%
		        List<Map<String, Object>> bidList = (List<Map<String, Object>>) request.getAttribute("bid_list");
		        if (bidList != null && !bidList.isEmpty()) {
		            for (Map<String, Object> bid : bidList) {
		        %>
								<tr>
									<td><%= bid.getOrDefault("bidder", "N/A") %></td>
									<td><%= bid.getOrDefault("bid_amount", "N/A") %></td>
									<td><%= bid.getOrDefault("added_on", "N/A") %></td>
									<td><input type="submit" value="Confirm"></td>
								</tr>
								<%
		            }
		        } else {
		        %>
								<tr>
									<td colspan="4">No bids available for this job.</td>
								</tr>
								<%
		        }
		        %>
							</table>
						</div>
						<%
		} else {  // User is not the job creator
		%>
						<div align="center">
							<h2>Submit Your Bid</h2>
							<form action="BidOnJobServlet" method="post">
								<input type="hidden" name="job_id"
									value="<%= jobDetails.get("job_id") %>"> <label
									for="bid_amount">Bid Amount:</label> <input type="text"
									id="bid_amount" name="bid_amount" required> <label
									for="message">Message:</label>
								<textarea id="message" name="message"></textarea>
								<br> <input type="submit" value="Submit Bid">
							</form>
						</div>
						<%
		}
	}
		%>
					</div>
				</div>
			</div>
		</div>
	</div>
	</div>
	</div>
	<jsp:include page="common/footer.jsp" />

</body>
</html>
