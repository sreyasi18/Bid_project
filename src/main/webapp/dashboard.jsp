
<%
request.setAttribute("activePage", "dashboard");
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

// retrieves all cookies from the request.
Cookie[] cookies = request.getCookies();

// initializes a string variable name to null.
String name = null;

//checks if there are any cookies.
if (cookies != null) {
	//The for loop iterates through all cookies to find the one with the name "user_name".
	//If the "user_name" cookie is found, its value is assigned to the name variable,
	//and the loop breaks.

	for (Cookie cookie : cookies) {
		if ("user_name".equals(cookie.getName())) {
	name = cookie.getValue();
	break;
		}
	}
}
%>
<div align="center">Welcome to [Your Website Name]! Your one-stop
	destination for [industry/service niche, e.g., innovative tech
	solutions, unique travel experiences, etc.]. Explore our services and
	join thousands of satisfied customers who trust us to deliver
	excellence every day.</div>
<jsp:include page="common/footer.jsp" />
