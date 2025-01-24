<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List, java.util.Map"%>
<%
request.setAttribute("activePage", "jobList");
%>

<jsp:include page="common/leftPanel.jsp" />
<jsp:include page="common/header.jsp" />

<script src="https://code.jquery.com/jquery-3.7.1.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.2/js/bootstrap.min.js"></script>
<script src="https://cdn.datatables.net/2.2.1/js/dataTables.js"></script>
<script src="https://cdn.datatables.net/2.2.1/js/dataTables.bootstrap4.js"></script>

<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/twitter-bootstrap/4.5.2/css/bootstrap.css">
<link rel="stylesheet" href="https://cdn.datatables.net/2.2.1/css/dataTables.bootstrap4.css">

<script>new DataTable('#example');</script>

<%
	// Check if the user is already logged in

	// retrieves the current session without creating a new one. null is returned if no session exists.
	HttpSession sessionObj = request.getSession(false);

	//The if statement checks if the session does not exist, if the "is_loggedin" attribute is not present,
	//or if the "is_loggedin" attribute does not equal 1 (indicating the user is not logged in).
	//If any condition is true:

	if (sessionObj == null) {
		out.println("Session is null. Redirecting to login page.");
		response.sendRedirect("login.jsp");
		return;
	} else if (sessionObj.getAttribute("is_loggedin") == null) {
		out.println("Session attribute 'is_loggedin' is null. Redirecting to login page.");
		response.sendRedirect("login.jsp");
		return;
	} else if (!sessionObj.getAttribute("is_loggedin").equals(1)) {
		out.println("User is not logged in. Redirecting to login page.");
		response.sendRedirect("login.jsp");
		return;
	}
	%>

<div align="center">
	<h1>Your Job List</h1>
</div>

<table id="example" class="table table-striped table-bordered display" style="width:100%">
	<thead>
		<tr>
			<th>Job Title</th>
			<th>Created At</th>
			<th>Status</th>
	
			<th>Actions</th>
		</tr>
	</thead>
	<tbody>
	<%
		List<Map<String, Object>> jobList = (List<Map<String, Object>>) request.getAttribute("job_list");
		if (jobList != null) {

			for (Map<String, Object> job : jobList) {
		%>
		<tr>
			<td><%=job.get("job_title")%></td>
			<td><%=job.get("created_at")%></td>
			<td><%=job.get("status")%></td>
			<td>
				<select name="action" id="action" onchange="updateJobStatus(<%=job.get("id")%>,this.value)">
					<option value="closed"
						<%=(job.get("status").equals("closed") ? "selected" : "")%>>Close</option>
					<option value="hold"
						<%=(job.get("status").equals("hold") ? "selected" : "")%>>Hold</option>
					<option value="assigned"
						<%=(job.get("status").equals("assigned") ? "selected" : "")%>>Assigned</option>
				</select>
				<button onclick="location.href='PostJobServlet?job_id=<%=job.get("id")%>'">Edit</button>
			</td>
			<td>
				<select name="action" id="action" onchange="updateJobStatus(<%=job.get("id")%>,this.value)">
					<option value="closed"
						<%=(job.get("status").equals("closed") ? "selected" : "")%>>Close</option>
					<option value="hold"
						<%=(job.get("status").equals("hold") ? "selected" : "")%>>Hold</option>
					<option value="assigned"
						<%=(job.get("status").equals("assigned") ? "selected" : "")%>>Assigned</option>
				</select>
			</td>
			<td>
				<button onclick="location.href='PostJobServlet?job_id=<%=job.get("id")%>'">Edit</button>
			</td>
			<td>
				<form action="JobDetailsServlet" method="get">
					<input type="hidden" name="job_id" value="<%=job.get("id")%>">
					<input type="submit" value="Details">
				</form>
			</td>
		</tr>
	
		<%
				}
			}
			%>
	</tbody>
</table>

<script>
$(document).ready(function() {
	  $('#example').DataTable({
	    pageLength: 10,
	    filter: true,
	    deferRender: true,
	    scrollY: 200,
	    scrollCollapse: true,
	    scroller: true,
	    "searching": true,
	  });
	});

function updateJobStatus(job_id, status) {
	//alert("PostJobServlet?job_id="+job_id+"&status=" + status);
    window.location.href = "PostJobServlet?job_id="+job_id+"&status=" + status;
}
</script>

<jsp:include page="common/footer.jsp" />