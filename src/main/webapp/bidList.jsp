<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List, java.util.Map"%>
<jsp:include page="common/leftPanel.jsp" />
<jsp:include page="common/header.jsp" />
<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Final Bid List</title>
</head>
<body>
	<div align="center">
		<a href="LogoutServlet">Logout</a> <a href="postJob.jsp">Post a
			Job</a> <a href="dashboard.jsp">dashboard</a> <a href="wishlist.jsp">Wish
			list</a> <br> <a href="FindJobServlet">Find a job</a>

	</div>


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
		<h1>Receive Bid List</h1>
	</div>

	<table border="1" align="center" style="width: 80%">
		<tr>
			<th>Job id</th>
			<th>User id</th>
			<th>Bid Amount</th>
			<th>Added On</th>
			<th>Updated On</th>

		</tr>

		<%
		List<Map<String, Object>> bidList = (List<Map<String, Object>>) request.getAttribute("bid_list");
		if (bidList != null) {

			for (Map<String, Object> job : bidList) {
		%>
		<tr>
			<td><%=job.get("job_id")%></td>
			<td><%=job.get("user_id")%></td>
			<td><%=job.get("bid_amount")%></td>
			<td><%=job.get("added_on")%></td>
			<td><%=job.get("updated_on")%></td>

		</tr>

		<%
		}
		}
		%>
	</table>

	<script>
		function updateJobStatus(job_id, status) {
			//alert("PostJobServlet?job_id="+job_id+"&status=" + status);
			window.location.href = "PostJobServlet?job_id=" + job_id
					+ "&status=" + status;
		}
	</script>
	<jsp:include page="common/footer.jsp" />

</body>
</html>
