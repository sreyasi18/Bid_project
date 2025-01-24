<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Login</title>
</head>
<body>
	<%
	// Check if the user is already logged in
	// retrieve the current session without creating a new one. If there is no existing session, null is returned.  
	HttpSession sessionObj = request.getSession(false);
	out.println(sessionObj.getAttribute("is_loggedin"));
	// Checks if the session exists and the "is_loggedin" attribute is not null.
	if (sessionObj != null && sessionObj.getAttribute("is_loggedin") != null) {

		// User is already logged in, redirect to the dashboard
		response.sendRedirect("dashboard.jsp");
		return; // Stop further execution of the JSP
	}

	// Display error message from session or cookies
	//Retrieves the "error" parameter from the request, if it exists.
	String error = request.getParameter("error");
	if (error != null) {//Checks if the "error" parameter is not null
		out.println("<p style='color:red;'>" + error + "</p>");
	}
	//Retrieves an array of cookies from the request.
	Cookie[] cookies = request.getCookies();
	String loginError = null;// Initializes the loginError variable to null

	if (cookies != null) {// Checks if the cookies array is not null
		for (Cookie cookie : cookies) {
			if ("error".equals(cookie.getName())) {
		loginError = cookie.getValue();
		break;
			}
		}

		if (loginError != null) {
			out.println("<div class='center error-message'><p>Invalid credential</p></div>");
		}
	}
	%>
<div class="container-fluid">
            <div class="row h-100 align-items-center justify-content-center" style="min-height: 100vh;">
                <div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
                    <div class="bg-light rounded p-4 p-sm-5 my-4 mx-3">
                        <div class="d-flex align-items-center justify-content-between mb-3">
	
						
					<div align="center">
						<h1>User Login</h1>
					</div>
					<form action="SubmitServelet" method="post">
						<div align="center">
							<table>
								<tr>
								 <div class="form-floating mb-3">
									<td>Enter name:</td>
									<td><input type="text" name="user_name" required></td>
								 </div>
								</tr>
								<tr>
								<div class="form-floating mb-4">
									<td>Enter password:</td>
									<td><input type="password" name="password" required></td>
									</div>
								</tr>
							</table>
							<div>
								<input type="submit" value="Login"> <input type="reset"
									value="Reset"> <br> <a href="registration.jsp">Register</a>
								| <a href="password.jsp">Forgot Password</a>
							</div>
						</div>
					</form>
</body>
</html>

<!DOCTYPE html>
<html>
<head>
<meta charset="ISO-8859-1">
<title>Registration Page</title>

</head>
<body>
<%
    HttpSession sessionObj = request.getSession(false);
    if (sessionObj != null && sessionObj.getAttribute("is_loggedin") != null) {
        response.sendRedirect("dashboard.jsp");
        return;
    }
%>

<form action="RegistrationServlet" method="post">
 <title>Registration Page</title>

    Enter name: <input type="text" name="name"/><br><br>

    Enter User Name: <input type="text" name="user_name"/><br><br>
    Enter Email: <input type="text" name="email"/><br><br>
    Enter Password: <input type="password" name="password"/><br><br>
    Confirm Password: <input type="password" name="confirm_password"/><br><br>
   
    <input type="submit" value="Submit">
    <a href="login.jsp">Login</a>
</form>
<jsp:include page="common/footer.jsp" />

</body>
</html>