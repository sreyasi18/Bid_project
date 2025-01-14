<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

<head>
<meta charset="utf-8">

<meta content="width=device-width, initial-scale=1.0" name="viewport">
<meta content="" name="keywords">
<meta content="" name="description">

<!-- Favicon -->
<link href="img/favicon.ico" rel="icon">

<!-- Google Web Fonts -->
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link
	href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap"
	rel="stylesheet">

<!-- Icon Font Stylesheet -->
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css"
	rel="stylesheet">
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css"
	rel="stylesheet">

<!-- Libraries Stylesheet -->
<link href="template/lib/owlcarousel/assets/owl.carousel.min.css"
	rel="stylesheet">
<link
	href="template/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css"
	rel="stylesheet" />

<!-- Customized Bootstrap Stylesheet -->
<link href="template/css/bootstrap.min.css" rel="stylesheet">

<!-- Template Stylesheet -->
<link href="template/css/style.css" rel="stylesheet">
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
	<div class="container-xxl position-relative bg-white d-flex p-0">
		<!-- Spinner Start -->
		<div id="spinner"
			class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
			<div class="spinner-border text-primary"
				style="width: 3rem; height: 3rem;" role="status">
				<span class="sr-only">Loading...</span>
			</div>
		</div>
		<!-- Spinner End -->


		<!-- Sign In Start -->
		<div class="container-fluid">
			<div class="row h-100 align-items-center justify-content-center"
				style="min-height: 100vh;">
				<div class="col-12 col-sm-8 col-md-6 col-lg-5 col-xl-4">
					<div class="bg-light rounded p-4 p-sm-5 my-4 mx-3">
						<div
							class="d-flex align-items-center justify-content-between mb-3">

							<h3>Sign In</h3>
						</div>
						<form action="SubmitServelet" method="post">
							<div class="form-floating mb-3">
								<input type="text" class="form-control" id="user_name"
									name="user_name" placeholder="Enter name" required> <label
									for="user_name">Enter Name</label>
							</div>

							<div class="form-floating mb-4">
								<input type="password" class="form-control" id="password"
									name="password" placeholder="Enter password" required>
								<label for="password">Enter Password</label>
							</div>

							<div
								class="d-flex align-items-center justify-content-between mb-4">
								<div class="form-check">
									<input type="checkbox" class="form-check-input"
										id="exampleCheck1"> <label class="form-check-label"
										for="exampleCheck1">Check me out</label>
								</div>
								<a href="password.jsp">Forgot Password</a>
							</div>
							<button type="submit" class="btn btn-primary py-3 w-100 mb-4">Sign
								In</button>
							<p class="text-center mb-0">
								Don't have an Account? <a href="registration.jsp">Sign Up</a>
							</p>
						</form>
					</div>
				</div>
			</div>
		</div>
		<!-- Sign In End -->
	</div>

	<!-- JavaScript Libraries -->
	<script src="https://code.jquery.com/jquery-3.4.1.min.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0/dist/js/bootstrap.bundle.min.js"></script>
	<script src="template/lib/chart/chart.min.js"></script>
	<script src="template/lib/easing/easing.min.js"></script>
	<script src="template/lib/waypoints/waypoints.min.js"></script>
	<script src="template/lib/owlcarousel/owl.carousel.min.js"></script>
	<script src="template/lib/tempusdominus/js/moment.min.js"></script>
	<script src="template/lib/tempusdominus/js/moment-timezone.min.js"></script>
	<script
		src="template/lib/tempusdominus/js/tempusdominus-bootstrap-4.min.js"></script>

	<!-- Template Javascript -->
	<script src="template/js/main.js"></script>
</body>

</html>