<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page import="java.util.List, java.util.Map"%>
<%
request.setAttribute("activePage", "findJob");
%>

<jsp:include page="common/leftPanel.jsp" />
<jsp:include page="common/header.jsp" />

<%
	HttpSession sessionObj = request.getSession(false);
	if(sessionObj == null){
		out.println("Session is null.Redirecting to login page.");
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
	<h1>find job</h1>
</div>

<table border="1" align="center" style="width: 80%">
	<tr>
		<th>Job Title</th>
		<th>Created At</th>
		<th>Status</th>

		<th>Actions</th>
	</tr>
	<%
    List<Map<String, Object>> findJob = (List<Map<String, Object>>) request.getAttribute("job_list");
	    if (findJob != null) {
	    	
	  
	        for (Map<String, Object> job : findJob) {
    %>
	<tr>
		<td><%= job.get("job_title") %></td>
		<td><%= job.get("created_at") %></td>
		<td><%= job.get("status") %></td>

		<td>
			<form action="JobDetailsServlet" method="get">
				<input type="hidden" name="job_id" value="<%= job.get("id") %>">
				<input type="submit" value="Details">
			</form>
		</td>
	</tr>
	<%
    
	        }
	    }
%>
</table>



<script>
function updateJobStatus(job_id, status) {
    // Redirect to FindJobServlet with job_id and status parameters
    window.location.href = "FindJobServlet?job_id=" + job_id + "&status=" + status;
}
</script>



<jsp:include page="common/footer.jsp" />
