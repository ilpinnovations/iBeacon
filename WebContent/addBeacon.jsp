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
<title>IBeacon-Dashboard</title>
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
							<li><a href="addBeacon.jsp" class="active-menu">Add New iBeacon</a></li>
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

	<div class="container">
		<div style="margin-top: 10px">
				</div>

		<div class="row">
			<div class="col-md-12">
				<!-- Form Elements -->
				<div class="panel panel-default">
					<div class="panel-heading">
						<span class="glyphicon glyphicon-th-list"></span> &nbsp; iBeacon details
					</div>

					<div class="panel-body">
						<div class="row" style="font-size: 12px">
						<div class="col-md-12">
						<%
		String val = session.getAttribute("userID").toString();
		
		int userID = Integer.valueOf(val);
		Connection cnn = DatabaseUtil.getConnection();
		PreparedStatement st1 = cnn
				.prepareStatement("select uuid from geo_user where user_id=?");
		st1.setInt(1,userID);
		ResultSet rs = st1.executeQuery();
			while(rs.next()){
				String uuid=rs.getString("uuid").toString().trim();
				if(uuid.equals("")||uuid==null){
			%>
			<button id='btn' style='display: none;' class="trigger error-trigger">Error</button>
			<div class="alert alert-danger fade in">
				<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
				You did not enter a UUID. Beacon notifications will not work. <strong><a href="configBeacon.jsp">Configure your UUID here</a></strong>
			</div>
			<%
				}
				
		}
		%>
		
		
			<%
				if (session.getAttribute("add") != null && "success".equals(session.getAttribute("add"))) {
					session.removeAttribute("add");
			%>
			<button id='btn' style='display: none;' class="trigger error-trigger">Error</button>
			<div class="alert alert-success fade in">
				<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
				<strong>Success!</strong> Beacon created successfully.
			</div>
			<%
				}
			%>
			<%
				if (session.getAttribute("add") != null && "failed".equals(session.getAttribute("add"))) {
					session.removeAttribute("add");
			%>
			<button id='btn' style='display: none;' class="trigger error-trigger">Error</button>
			<div class="alert alert-danger fade in">
				<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
				<strong>Failed!</strong> Beacon could not be created. Please try
				again later.
			</div>
			<%
				}
			%>
<%
				if (session.getAttribute("add") != null && "failedName".equals(session.getAttribute("add"))) {
					session.removeAttribute("add");
			%>
			<button id='btn' style='display: none;' class="trigger error-trigger">Error</button>
			<div class="alert alert-danger fade in">
				<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
				<strong>Failed!</strong> Beacon Name already exists.
			</div>
			<%
				}
			%>

						
						</div>
							<div class="col-md-6">
								<form role="form" action='AddBeacon'>
									<div class="form-group">
										<label>iBeacon Name</label> <input class="form-control" required="required" title="Beacon name can not be left blank"
											name='bName' />
									</div>

									<div class="form-group">
										<label>Major ID</label> <input type="number" class="form-control" required="required" title="Major ID is mandatory"
											name='major' />
									</div>
									<div class="form-group">
										<label>Minor ID(optional)</label> <input type="number" class="form-control"
											name='minor' />
									</div>
									
									<button type="submit" class="btn btn-success">
										<span class="glyphicon glyphicon-map-marker"
											aria-hidden="true"></span> Create
									</button>

								</form>

							</div>
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
	<script type="text/javascript">
		// This example adds a search box to a map, using the Google Place Autocomplete
		// feature. People can enter geographical searches. The search box will return a
		// pick list containing a mix of places and predicted search terms.

		function initAutocomplete() {
			var latitude1 = 21.00000;
			var longitude1 = 78.00000;
			var myLatlng = new google.maps.LatLng(latitude1, longitude1);

			var map = new google.maps.Map(document.getElementById('map'), {

				center : myLatlng,
				zoom : 4,
				mapTypeId : google.maps.MapTypeId.ROADMAP
			});

			// Create the search box and link it to the UI element.
			var input = document.getElementById('pac-input');
			var searchBox = new google.maps.places.SearchBox(input);
			map.controls[google.maps.ControlPosition.TOP_LEFT].push(input);

			// Bias the SearchBox results towards current map's viewport.
			map.addListener('bounds_changed', function() {
				searchBox.setBounds(map.getBounds());
			});

			var markers = [];
			// [START region_getplaces]
			// Listen for the event fired when the user selects a prediction and retrieve
			// more details for that place.
			searchBox
					.addListener(
							'places_changed',
							function() {

								var places = searchBox.getPlaces();
								if (places.length == 0) {
									return;
								}

								// Clear out the old markers.
								markers.forEach(function(marker) {
									marker.setMap(null);
								});
								markers = [];

								// For each place, get the icon, name and location.
								var bounds = new google.maps.LatLngBounds();
								places
										.forEach(function(place) {
											var icon = {
												url : place.icon,
												size : new google.maps.Size(71,
														71),
												origin : new google.maps.Point(
														0, 0),
												anchor : new google.maps.Point(
														17, 34),
												scaledSize : new google.maps.Size(
														25, 25)
											};

											// Create a marker for each place.
											test = new google.maps.Marker(
													{
														map : map,
														icon : icon,
														title : place.name,
														draggable : true,
														position : place.geometry.location
													});
											document.getElementById("latitude").value = place.geometry.location
													.lat();
											document
													.getElementById("longitude").value = place.geometry.location
													.lng();
											test.setVisible(true);
											markers.push(test);

											google.maps.event.addListener(test,
													function() {

													});
											if (place.geometry.viewport) {
												// Only geocodes have viewport.
												bounds
														.union(place.geometry.viewport);
											} else {
												bounds
														.extend(place.geometry.location);

											}
											/* 
											 document.getElementsByName("latitude").value=place.geometry.location.lat();
											 document.getElementsByName("longitude").value=place.geometry.location.lng(); */
										});
								map.fitBounds(bounds);

							});
			// [END region_getplaces]
		}
	</script>
	<script
		src="https://maps.googleapis.com/maps/api/js?key=AIzaSyDP3kLPO-Pybx8ILFqYjp16912djvicGfo&libraries=places&callback=initAutocomplete"
		async defer></script>
</body>
</html>