<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<%@ page
	import="java.sql.*, javax.servlet.http.*, javax.servlet.*, java.util.*"%>
<<<<<<< HEAD
	<a href="BidOnJobServlet" 
   class="nav-item nav-link ${activePage == 'BidOnJobServlet' ? 'active' : ''}">
    <i class="fa fa-gavel me-2"></i>My Bids
</a>

=======
>>>>>>> f03926084126c9a944e639dc6f041b6ead722873
<!DOCTYPE html>
<html>
<head>
<title>Submit Bid</title>
</head>
<body>


	<h2>Submit your Bid</h2>
	<form action="BidOnJobServlet" method="post">
		<input type="hidden" name="job_id" value="${param.job_id}">
		<p>Job ID: ${param.job_id}</p>

		Bid Amount: <input type="text" name="bid_amount" required><br>

		Message:
		<textarea name="message" required></textarea>
		<br> <input type="submit" value="Submit Bid">
	</form>


</body>
</html>
