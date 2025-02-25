<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="utf-8">
    <title>DASHMIN - Bootstrap Admin Template</title>
    <meta content="width=device-width, initial-scale=1.0" name="viewport">
    <meta content="" name="keywords">
    <meta content="" name="description">

    <!-- Favicon -->
    <link href="img/favicon.ico" rel="icon">

    <!-- Google Web Fonts -->
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Heebo:wght@400;500;600;700&display=swap" rel="stylesheet">
    
    <!-- Icon Font Stylesheet -->
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.10.0/css/all.min.css" rel="stylesheet">
    <link href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.4.1/font/bootstrap-icons.css" rel="stylesheet">

    <!-- Libraries Stylesheet -->
    <link href="template/lib/owlcarousel/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="template/lib/tempusdominus/css/tempusdominus-bootstrap-4.min.css" rel="stylesheet" />

    <!-- Customized Bootstrap Stylesheet -->
    <link href="template/css/bootstrap.min.css" rel="stylesheet">

    <!-- Template Stylesheet -->
    <link href="template/css/style.css" rel="stylesheet">
</head>

<body>
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
    <div class="container-xxl position-relative bg-white d-flex p-0">
        <!-- Spinner Start -->
        <div id="spinner" class="show bg-white position-fixed translate-middle w-100 vh-100 top-50 start-50 d-flex align-items-center justify-content-center">
            <div class="spinner-border text-primary" style="width: 3rem; height: 3rem;" role="status">
                <span class="sr-only">Loading...</span>
            </div>
        </div>
        <!-- Spinner End -->


        <!-- Sidebar Start -->
        <div class="sidebar pe-4 pb-3">
            <nav class="navbar bg-light navbar-light">
                <a href="index.html" class="navbar-brand mx-4 mb-3">
                    <h3 class="text-primary"><i class="fa fa-hashtag me-2"></i>EasyBid</h3>
                </a>
                <div class="d-flex align-items-center ms-4 mb-4">
                    <div class="position-relative">
                        <img class="rounded-circle" src="img/user.jpg" alt="" style="width: 40px; height: 40px;">
                        <div class="bg-success rounded-circle border border-2 border-white position-absolute end-0 bottom-0 p-1"></div>
                    </div>
                    <div class="ms-3">
                        <h6 class="mb-0"><% out.println(name); %></h6>
                        <span>Admin</span>
                    </div>
                </div>
                <div class="navbar-nav w-100">
				 <a href="dashboard.jsp" class="nav-item nav-link <% if ("dashboard".equals(request.getAttribute("activePage"))) { %>active<% } %>">
				        <i class="fa fa-tachometer-alt me-2"></i>Dashboard
				    </a>                
				 <a href="postJob.jsp" class="nav-item nav-link <% if ("postJob".equals(request.getAttribute("activePage"))) { %>active<% } %>">
				        <i class="fa fa-briefcase me-2"></i>Post a Job
				    </a>
				<a href="JobList_Servlet" class="nav-item nav-link <% if ("jobList".equals(request.getAttribute("activePage"))) { %>active<% } %>">
				        <i class="fa fa-list me-2"></i>My Job List
				    </a>
				 <a href="FindJobServlet" class="nav-item nav-link <% if ("findJob".equals(request.getAttribute("activePage"))) { %>active<% } %>">
				        <i class="fa fa-search me-2"></i>Find a Job
				    </a>
				<a href="BidOnJobServlet" class="nav-item nav-link <% if ("myBids".equals(request.getAttribute("activePage"))) { %>active<% } %>">
				        <i class="fa fa-gavel me-2"></i>My Bids
				    </a>
                      <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="fa fa-laptop me-2"></i>Elements</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="button.html" class="dropdown-item">Buttons</a>
                            <a href="typography.html" class="dropdown-item">Typography</a>
                            <a href="element.html" class="dropdown-item">Other Elements</a>
                        </div>
                    </div>
                    <a href="widget.html" class="nav-item nav-link"><i class="fa fa-th me-2"></i>Widgets</a>
                    <a href="form.html" class="nav-item nav-link"><i class="fa fa-keyboard me-2"></i>Forms</a>
                    <a href="table.html" class="nav-item nav-link"><i class="fa fa-table me-2"></i>Tables</a>
                    <a href="chart.html" class="nav-item nav-link"><i class="fa fa-chart-bar me-2"></i>Charts</a>
                    <div class="nav-item dropdown">
                        <a href="#" class="nav-link dropdown-toggle" data-bs-toggle="dropdown"><i class="far fa-file-alt me-2"></i>Pages</a>
                        <div class="dropdown-menu bg-transparent border-0">
                            <a href="login.jsp" class="dropdown-item">log in</a>
                            <a href="registration.jsp" class="dropdown-item">Sign Up</a>
                            <a href="404.html" class="dropdown-item">404 Error</a>
                            <a href="blank.html" class="dropdown-item">Blank Page</a>
                        </div>
                    </div>
                </div>
            </nav>
        </div>
        <!-- Sidebar End -->