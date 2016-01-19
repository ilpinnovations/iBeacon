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
<title>IBeacon-User Profile</title>
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
					<li class="dropdown"><a href="plugin.jsp">Plugin </a></li>
				</ul>
				</nav>
			</div>
			<div class="navigation" style="float: right">
				<nav>
				<ul class="nav topnav bold">
					<li class="dropdown"><a href="#" class="active-menu"><i
							class="glyphicon glyphicon-user"></i><%=session.getAttribute("userName")%>
							<i class="icon-angle-down"></i></a>
						<ul style="display: none;" class="dropdown-menu bold">
							<li><a href="LogOutUser">Log Out </a></li>
							<li><a href="viewProfile.jsp"  class="active-menu">User Profile</a></li>
						</ul></li>

				</ul>
				</nav>
			</div>
			<!-- end navigation -->
		</div>
	</div>
	</header>
	<!-- end header -->

	<div class="container">
		<div style="margin-top: 10px">
			<div class="row">
				<div class="col-md-12">
					<!-- Form Elements -->
					<div class="panel panel-default">
						<div class="panel-heading">
							<span class="glyphicon glyphicon-th-list"></span>&nbsp; View Profile
						</div>

						<div class="panel-body">
							<div class="row" style="font-size: 12px">
								<div class="col-md-12">
									<%
										if (session.getAttribute("msg") != null && "success".equals(session.getAttribute("msg"))) {
											session.removeAttribute("msg");
									%>
									<button id='btn' style='display: none;'
										class="trigger error-trigger">Error</button>
									<div class="alert alert-success fade in">
										<a href="#" class="close" data-dismiss="alert"
											aria-label="close">&times;</a> <strong>Success!</strong> User
										details updated successfully.
									</div>
									<%
										}
									%>
									<%
										if (session.getAttribute("msg") != null && "failed".equals(session.getAttribute("msg"))) {
											session.removeAttribute("msg");
									%>
									<button id='btn' style='display: none;'
										class="trigger error-trigger">Error</button>
									<div class="alert alert-danger fade in">
										<a href="#" class="close" data-dismiss="alert"
											aria-label="close">&times;</a> <strong>Failed!</strong> User
										details could not be updated. Please try again later.
									</div>
									<%
										}
									%>
<%
										if (session.getAttribute("msg") != null && "failed".equals(session.getAttribute("msg"))) {
											session.removeAttribute("msg");
									%>
									<button id='btn' style='display: none;'
										class="trigger error-trigger">Error</button>
									<div class="alert alert-danger fade in">
										<a href="#" class="close" data-dismiss="alert"
											aria-label="close">&times;</a> <strong>Failed!</strong> Old password is incorrect.
									</div>
									<%
										}
									%>

								</div>
								<form action='UpdateProfile' role="form" method='post'>
									<div class="col-md-6">
										<div class="form-group">
											<label>Token ID</label> <input class="form-control"
												name='tokenID' value='<%=session.getAttribute("tokenID")%>'
												readonly />
										</div>
										<div class="form-group">
											<label>User Name</label> <input class="form-control"
												name='userName' required="required"
												title="User Name cannot be left blank"
												value='<%=session.getAttribute("userName")%>' />
										</div>
										<div class="form-group">
											<label>Email Address</label> <input type="email"
												class="form-control" name='email'
												value='<%=session.getAttribute("email")%>'
												required="required" title="Email cannot be left blank" />
										</div>
										<div class="form-group">
											<label>Password</label> <input class="form-control" type="password"
												 required="required" readonly="readonly"
												title="Password is mandatory"
												value='<%=session.getAttribute("password")%>' />
										</div>
										<div class="panel-group">
  <div class="panel panel-default">
    <div class="panel-heading">
      <h4 class="panel-title">
        <a data-toggle="collapse" href="#collapse1">Collapsible panel</a>
      </h4>
    </div>
    <div id="collapse1" class="panel-collapse collapse">
      <div class="panel-body">Panel Body</div>
      <div class="panel-footer">Panel Footer</div>
    </div>
  </div>
</div>
										
										
										<a data-toggle="collapse" href="#demo" class="btn btn-default">
										Change Password
										</a>
										<div id="demo" class="collapse">
										<div class="form-group">
											<label>Old Password</label> <input class="form-control" type="password"
												name='oldpassword' required="required" readonly="readonly"
												title="Password is mandatory" />
										</div>
										<div class="form-group">
											<label>New Password</label> <input class="form-control" type="password"
												name='newpassword' required="required" readonly="readonly"
												title="Password is mandatory" />
										</div>
										
										
										</div>
										
										
										
										<button type="submit" class="btn btn-success">
											<span class="glyphicon glyphicon-user" aria-hidden="true"></span>
											Update Profile
										</button>
									</div>

								</form>
							</div>
						</div>
					</div>
					<!-- End Form Elements -->

				</div>
				<!-- /. ROW  -->

			</div>
			<!-- /. PAGE INNER  -->
		</div>
		<!-- /. PAGE WRAPPER  -->
	</div>



	<!-- javascript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery.js"></script>
	<script src="js/custom.js"></script>

</body>
</html>



