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
<title>IBeacon-View Notifications</title>
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
					<li class="dropdown"><a href="#" class="active-menu">Notifications
							<i class="icon-angle-down"></i>
					</a>
						<ul class="dropdown-menu bold">
							<li><a href="viewNotification.jsp" class="active-menu">View
									Notifications</a></li>
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
			<div class="row">
				<div class="col-md-12">
					<!-- Form Elements -->
					<div class="panel panel-default">
						<div class="panel-heading">
							<i class="fa fa-edit fa-1x"></i> &nbsp; Notification
						</div>

						<div class="panel-body">
							<div class="row" style="font-size: 12px; margin: 10px">


								<%
									if (session.getAttribute("delete") != null && "success".equals(session.getAttribute("delete"))) {
										session.removeAttribute("delete");
								%>
								<button id='btn' style='display: none;'
									class="trigger error-trigger">Error</button>
								<div class="alert alert-success fade in">
									<a href="#" class="close" data-dismiss="alert"
										aria-label="close">&times;</a> <strong>Success!</strong>
									Notification deleted successfully.
								</div>
								<%
									}
								%>
								<%
									if (session.getAttribute("delete") != null && "failed".equals(session.getAttribute("delete"))) {
										session.removeAttribute("delete");
								%>
								<button id='btn' style='display: none;'
									class="trigger error-trigger">Error</button>
								<div class="alert alert-danger fade in">
									<a href="#" class="close" data-dismiss="alert"
										aria-label="close">&times;</a> <strong>Failed!</strong>
									Notification could not be deleted. Please try again later.
								</div>
								<%
									}
								%>


								<table class="table" border="1" bordercolor="#E0E0E0">
									<thead
										style="background-image: url('img/header-pattern-150.png'); color: white;">
										<tr>
											<th colspan="3" style="text-align: center;">Notification</th>
											<th colspan="2" style="text-align: center;">iBeacon</th>

										</tr>
									</thead>
									<thead
										style="background: -webkit-linear-gradient(rgb(192, 188, 184), rgb(255, 255, 255));">
										<tr>
											<th style="text-align: center;">Status</th>
											<th style="text-align: center;">Message</th>
											<th style="text-align: center;">Delete</th>
											<th style="text-align: center;">Name</th>
											<th style="text-align: center;">Radius</th>

										</tr>
									</thead>

									<%
										Connection cnn = null;
										ResultSet rs = null;
										PreparedStatement pst = null;
										try {
											int beacon_id = 0;
											String tokenID = (String) session.getAttribute("tokenID");
											cnn = DatabaseUtil.getConnection();
											int userID = Integer.parseInt(session.getAttribute("userID").toString());

											try {
												pst = cnn.prepareStatement("SELECT * FROM b_notify WHERE beacon_id =?");

												beacon_id = Integer.parseInt(request.getParameter("beacon_id"));
												pst.setInt(1, beacon_id);
												rs = pst.executeQuery();
											} catch (Exception e) {
												pst = cnn.prepareStatement("SELECT * FROM b_notify WHERE token_id =?");
												pst.setString(1, tokenID);

												rs = pst.executeQuery();
											} finally {

												if (DatabaseUtil.getRowCount(rs) > 0) {
													while (rs.next()) {
														beacon_id = rs.getInt("beacon_id");
									%>


									<tbody>
										<tr>
											<%
												PreparedStatement pst1 = cnn.prepareStatement("SELECT * FROM add_beacon WHERE beacon_id=?");
																pst1.setInt(1, beacon_id);
																String beaconName = null;

																ResultSet rs1 = pst1.executeQuery();
																while (rs1.next()) {
																	beaconName = rs1.getString("beacon_name");
																}
											%>
											<td><%=rs.getString("status")%></td>
											<td><%=rs.getString("notification")%></td>
											<td><a
												href="<%=request.getContextPath()%>/deleteNotification?notify_id=<%=rs.getInt("notify_id")%>"
												style="text-align: center" class="glyphicon glyphicon-trash"
												aria-hidden="true"></span></td>
											<td><%=beaconName%></td>
											<td><%=rs.getString("radius")%></td>

										</tr>
									</tbody>


									<%
										}
												} else {
									%>
									<tbody>
										<tr>
											<td colspan="5" style="text-align: center;"><b>No
													Notifications found</b></td>

										</tr>
									</tbody>
									<%
										}
											}
										} catch (Exception e) {
											e.printStackTrace();
										}
									%>


								</table>



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



