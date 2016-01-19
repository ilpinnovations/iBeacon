<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.tcs.util.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	if (session.getAttribute("userID") == null) {
		//request.getRequestDispatcher("index.jsp").forward(request, response);
		response.sendRedirect("index.jsp");
	}
%>

<html>
<head>
<link href="css/menu.css" rel="stylesheet">
<link href="css/style.css" rel="stylesheet">

<link href="css/bootstrap.css" rel="stylesheet" />
<!-- FONTAWESOME STYLES-->
<link href="css/font-awesome.css" rel="stylesheet" />
<!-- CUSTOM STYLES-->
<link href="css/custom.css" rel="stylesheet" />

<link rel="icon" type="image/png" href="img/Icon11.png">
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>IBeacon-Plugin</title>
</head>
<body style="background: url('img/back.jpg');">
	<!-- start header -->
	<header>
	<div class="container">
		<div class="navbar navbar-static-top">
			<div class="navigation">
				<nav>
				<ul class="nav topnav bold">
					<li class="dropdown"><a href="#">Last Login : <%=session.getAttribute("lastVisit")%></a></li>
				</ul>
				</nav>
			</div>
			<!-- end navigation -->
		</div>
	</div>
	<hr>
	<div class="container">
		<div class="navbar navbar-static-top">
			<div class="navigation" style="float: left">
				<nav>
				<ul class="nav topnav bold">
					<li class="dropdown"><a href="#">iBeacons <i
							class="icon-angle-down"></i>
					</a>
						<ul class="dropdown-menu bold">
							<li><a href="dashboard.jsp">iBeacon Dashboard</a></li>
							<li><a href="addBeacon.jsp">Add New iBeacon</a></li>
							<li><a href="configBeacon.jsp">Configure iBeacon</a></li>
						</ul></li>
					<li class="dropdown"><a href="#">Notifications <i
							class="icon-angle-down"></i></a>
						<ul class="dropdown-menu bold">
							<li><a href="viewNotification.jsp">View Notifications</a></li>
							<li><a href="addNotification.jsp">Add Notifications</a></li>
						</ul></li>
					<li class="dropdown"><a href="plugin.jsp" class="active-menu">Plugin
					</a></li>
				</ul>
				</nav>
			</div>
			<div class="navigation" style="float: right">
				<nav>
				<ul class="nav topnav bold">
					<li class="dropdown"><a href="#"><i
							class="glyphicon glyphicon-user"></i><%=session.getAttribute("userName")%>
							<i class="icon-angle-down"></i></a>
						<ul style="display: none;" class="dropdown-menu bold">
							<li><a href="LogOutUser">Log Out </a></li>
							<li><a href="viewProfile.jsp">User Profile</a></li>
						</ul></li>

				</ul>
				</nav>
			</div>
			<!-- end navigation -->
		</div>
	</div>
	</header>
	<!-- end header -->
	<!-- /. NAV SIDE  -->
	<div class="container">
		<div style="margin-top: 10px">
			<div class="row">
				<div class="col-md-12">
					<!-- Form Elements -->
					<div class="panel panel-default">
						<div class="panel-heading">
							<span class="glyphicon glyphicon-th-list"></span>&nbsp; Integrate
							Plugin into your app
						</div>
						<div class="col-md-3">
							<br>
							<div class="panel panel-default">
								<div class="panel-body" style="margin: 10px">
									<div class="row" style="font-size: 12px">
									<img src="img/Logo Your App.png" height="200px" width="230px"><br>
									<br><br>
										We offer an API to manage your notifications programmatically.
										<br>Here is an instruction on How to use this API<br><br>
										<br>
										<form action="<%=request.getContextPath()%>/DownloadJSON"
											method='post'>
											<button class="btn btn-lg btn-block btn-success">
												<i class="glyphicon glyphicon-download"></i> &nbsp;Download
												API
											</button>
										</form>
									</div>
								</div>
							</div>
						</div>
						<div class="col-md-3">
							<br>
							<div class="panel panel-default">
								<div class="panel-body" style="margin: 10px">
									<div class="row" style="font-size: 12px">
										Want to integrate the Plot Plugin into your app straight away?
										<a href="<%=request.getContextPath()%>/DownloadJSON">Download
											them here.</a> <br> <br> This is the token to use in
										your App:<br> <b><code><%=session.getAttribute("tokenID")%></code></b>
										<br> <br> Your beacon.json configuration file should
										look like this:<br> <br>
										<code>
											{<br> "publicToken": "<%=session.getAttribute("tokenID")%>",<br>
											}
										</code>
										<br> <br> Create the file at the following location
										in your project:<br> <br> Android:&emsp;&emsp;
										assets/token.json <br> <br>
										<form action="<%=request.getContextPath()%>/DownloadJSON"
											method='post'>
											<button class="btn btn-lg btn-block btn-success">
												<i class="glyphicon glyphicon-download"></i> &nbsp;Download
												Plugin
											</button>
										</form>
									</div>
								</div>
							</div>
						</div>


						<!-- /item -->

						<div class="row" align="right" style="margin-top: 50px">
							<div class="col-md-3">
								<img src='img/animated-marker.gif' height='200px' width='125px'>
							</div>
						</div>

					</div>

				</div>
				</section>
				<!-- /Plans -->

			</div>

		</div>

	</div>

	<script src="js/bootstrap.js"></script>
	<!-- METISMENU SCRIPTS -->
	<script src="js/jquery.metisMenu.js"></script>

	<script src="js/jquery.js"></script>
	<script src="js/custom.js"></script>
</body>
</html>

</body>
</html>