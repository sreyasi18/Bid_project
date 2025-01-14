<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html>
<!-- Declares the document type and version of HTML -->
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
</head>
<body>
	<div align=center>
		<h1>User Login</h1>
	</div>
	<form action="BidSubmit" method="post">
		<div align=center>
			<table>
				<tr>
					<td>Enter name:</td>
					<td><input type="text" name="txtName"></td>
				</tr>
				<tr>
					<td>Enter password:</td>
					<td><input type="password" name="txtPassword"></td>
				</tr>
				<tr>
					<td><input type="reset"></td>
				</tr>

				<a href="dashboard.jsp" class="login-button">Login</a>

			</table>
	</form>
	</div>
	<div align=center>
		<a href="registration.jsp">Register</a> | <a href="password.jsp">Forgot
			Password</a>
	</div>
</body>
</html>
