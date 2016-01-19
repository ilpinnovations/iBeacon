<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1" import="com.tcs.util.*,java.sql.*"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<%
	if (session.getAttribute("userID") == null) {
		request.getRequestDispatcher("index.jsp").forward(request, response);
		//response.sendRedirect("index.jsp");
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
<title>IBeacon-Configure iBeacon</title>
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
					<li class="dropdown"><a href="#" class="active-menu">iBeacons
							<i class="icon-angle-down"></i>
					</a>
						<ul class="dropdown-menu bold">
							<li><a href="dashboard.jsp">iBeacon Dashboard</a></li>
							<li><a href="addBeacon.jsp">Add New iBeacon</a></li>
							<li><a href="configBeacon.jsp" class="active-menu">Configure iBeacon</a></li>
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

	<div class="container">
		<div style="margin-top: 10px">
			<%
				if (session.getAttribute("config") != null && "success".equals(session.getAttribute("config"))) {
					session.removeAttribute("config");
			%>
			<button id='btn' style='display: none;' class="trigger error-trigger">Error</button>
			<div class="alert alert-success fade in">
				<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
				<strong>Success!</strong> Configuration saved.
			</div>
			<%
				}
			%>
			<%
				if (session.getAttribute("config") != null && "failed".equals(session.getAttribute("config"))) {
					session.removeAttribute("config");
			%>
			<button id='btn' style='display: none;' class="trigger error-trigger">Error</button>
			<div class="alert alert-danger fade in">
				<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
				<strong>Failed!</strong> Beacon could not be configured. Please try
				again later.
			</div>
			<%
				}
			%>

		</div>
<%
		String val = session.getAttribute("userID").toString();
		String uuid="";
		int userID = Integer.valueOf(val);
		Connection cnn = DatabaseUtil.getConnection();
		PreparedStatement st1 = cnn
				.prepareStatement("select uuid from geo_user where user_id=?");
		st1.setInt(1,userID);
		ResultSet rs = st1.executeQuery();
								
		if(DatabaseUtil.getRowCount(rs)>0){
			while(rs.next()){
				uuid=rs.getString(1).trim();
				if(uuid==null||uuid=="NULL"){
					uuid="";
				}
			}
		}else{
			uuid="";
		}
			%>
		
		<div class="row">
			<div class="col-md-12">
				<!-- Form Elements -->
				<div class="panel panel-default">
					<div class="panel-heading">
						<span class="glyphicon glyphicon-th-list"></span>&nbsp; App iBeacon Configuration
					</div>

					<div class="panel-body">
						<div class="row" style="font-size: 12px">
							<div class="col-md-6">
								<form role="form" action='configBeacon'>
									<div class="form-group">
										<label>UUID</label> <input class="form-control" value="<%=uuid.trim() %>"
											name='uuid' />
									</div>
									<button type="submit" class="btn btn-success">
										<span class="glyphicon glyphicon-plus"
											aria-hidden="true"></span> Save
									</button>

								</form>
								</div>
							
						</div>
				<div>
									<p style="font-size: 12px">All your iBeacons should share a single proximity UUID.
										This is a 128-bit value that uniquely identifies the beacons
										of a certain organization. Setting the UUID is required before
										iBeacon notifications can be received on your devices.</p>
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