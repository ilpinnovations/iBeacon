<%@page import="org.apache.jasper.tagplugins.jstl.core.Catch"%>
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
<title>IBeacon-Add iBeacon</title>
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
							<li><a href="addBeacon.jsp">Add New iBeacon</a></li>
							<li><a href="configBeacon.jsp">Configure iBeacon</a></li>
						</ul></li>
					<li class="dropdown"><a href="#" class="active-menu">Notifications
							<i class="icon-angle-down"></i>
					</a>
						<ul class="dropdown-menu bold">
							<li><a href="viewNotification.jsp">View Notifications</a></li>
							<li><a href="addNotification.jsp" class="active-menu">Add
									Notifications</a></li>
						</ul></li>
					<li class="dropdown"><a href="plugin.jsp">Plugin </a></li>
				</ul>
				</nav>
			</div>
			<div class="navigation" style="float: right">
				<nav>
				<ul class="nav topnav bold">
					<li class="dropdown"><a href="#"><i
							class="glyphicon glyphicon-log-out"></i><%=session.getAttribute("userName")%>
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
							<span class="glyphicon glyphicon-th-list"></span>&nbsp; Add
							Notification
						</div>

						<div class="panel-body">



							<div class="row" style="font-size: 12px">





								<div class="col-md-12">
									<%
										if (session.getAttribute("notify") != null && "success".equals(session.getAttribute("notify"))) {
											session.removeAttribute("notify");
									%>
									<button id='btn' style='display: none;'
										class="trigger error-trigger">Error</button>
									<div class="alert alert-success fade in">
										<a href="#" class="close" data-dismiss="alert"
											aria-label="close">&times;</a> <strong>Success!</strong>
										Notification created successfully.
									</div>
									<%
										}
									%>
									<%
										if (session.getAttribute("notify") != null && "failed".equals(session.getAttribute("notify"))) {
											session.removeAttribute("notify");
									%>
									<button id='btn' style='display: none;'
										class="trigger error-trigger">Error</button>
									<div class="alert alert-danger fade in">
										<a href="#" class="close" data-dismiss="alert"
											aria-label="close">&times;</a> <strong>Failed!</strong>
										Notification could not be created. Please try again later.
									</div>
									<%
										}
									%>



									<%
										Connection cnn = null;
										ResultSet rs = null;

										try {
											cnn = DatabaseUtil.getConnection();

											int userID = Integer.parseInt(session.getAttribute("userID").toString());
											PreparedStatement pst = cnn.prepareStatement("SELECT uuid FROM geo_user WHERE user_id =?");
											pst.setInt(1, userID);
											rs = pst.executeQuery();
											String uuid = "";
											while (rs.next()) {
												uuid = rs.getString("uuid").toString().trim();
												if (uuid.equals("") || uuid == null) {
									%>
									<button id='btn' style='display: none;'
										class="trigger error-trigger">Error</button>
									<div class="alert alert-danger fade in">
										<a href="#" class="close" data-dismiss="alert"
											aria-label="close">&times;</a> <strong>Sorry!</strong> You
										did not enter a UUID. Beacon notifications will not work. <strong><a
											href="configBeacon.jsp">Enter a UUID here</a></strong>.
									</div>
									<%
										} else {
													uuid = rs.getString("uuid");
												}
												PreparedStatement pst1 = cnn
														.prepareStatement("SELECT beacon_name from add_beacon WHERE user_id =?");
												pst1.setInt(1, userID);
												ResultSet rs1 = pst1.executeQuery();

												int rowCount1 = DatabaseUtil.getRowCount(rs1);
												if (rowCount1 == 0) {
									%>
									<button id='btn' style='display: none;'
										class="trigger error-trigger">Error</button>
									<div class="alert alert-danger fade in">
										<a href="#" class="close" data-dismiss="alert"
											aria-label="close">&times;</a> <strong>Sorry!</strong> You
										have not added any beacon. Please <strong><a
											href="addBeacon.jsp">create a beacon</a></strong> to continue creating
										notifications.
									</div>

									<%
										} else {
									%>
								</div>
								<div class="col-md-6">
									<form role="form" action='AddNotification'>
										<div class="form-group">
											<label>iBeacon Name</label> <select id="bName" name="bName"
												class="form-control">
												<%
													try {
																	while (rs1.next()) {
																		String b_name = rs1.getString("beacon_name");
												%>
												<option value="<%=b_name%>"><%=b_name%></option>
												<%
													}
																} catch (Exception e) {
																	System.out.print(e);
																}
												%>
											</select>
										</div>

										<div class="form-group">
											<label>Notification message</label> <textarea class="form-control"
												required="required" title="Notification is mandatory"
												name='notification'></textarea>
										</div>
										<div class="form-group">
											<label>iBeacon Radius</label> <input type="number"
												class="form-control" name='radius' max="70"
												required="required" title="Radius is mandatory" />
										</div>

										<button type="submit" class="btn btn-success">
											<span class="glyphicon glyphicon-map-marker"
												aria-hidden="true"></span> Create Notification
										</button>
									</form>


								</div>
								<%
									}
										}
									} catch (Exception e) {
										System.out.print(e);
									}
								%>
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
	<script type="text/javascript">
		function save() {
			window.open('newUser.jsp', '_blank',
					'height=800, width=500, resizable=no, top=100, left= 400');
		}
	</script>


	<!-- javascript
    ================================================== -->
	<!-- Placed at the end of the document so the pages load faster -->
	<script src="js/jquery.js"></script>
	<script src="js/custom.js"></script>
</body>
</html>