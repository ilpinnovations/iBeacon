<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
	pageEncoding="ISO-8859-1"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=ISO-8859-1">
<title>IBeacon - Registration Success!</title>
</head>

<!-- BOOTSTRAP STYLES-->
<link href="css/bootstrap.css" rel="stylesheet" />
<!-- FONTAWESOME STYLES-->
<link href="css/font-awesome.css" rel="stylesheet" />
<!-- CUSTOM STYLES-->
<link href="css/custom.css" rel="stylesheet" />
<link rel="icon" type="image/png" href="images/favicon.png">



<!--  Including Scripts and CSS -->

<link rel="icon" type="image/png" href="images/favicon.png">

<!-- Custom Theme files -->
<link href="css/style.css" rel="stylesheet" type="text/css" media="all" />

<!-- Custom Theme files -->
<meta name="viewport" content="width=device-width, initial-scale=1">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8" />

<link rel="stylesheet" href="css/formValidation.css" />



<!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
<script src="js/jquery-1.11.3.js"></script>
<script src="js/bootstrap.js"></script>
<script type="text/javascript" src="js/formValidation.js"></script>
<script src="js/framework/bootstrap.js"></script>
<script src="js/menu_jquery.js"></script>
<!--  End of Scripts and CSS -->


<body>

	<div class="container">

		<%
			if (session.getAttribute("config") != null && "success".equals(session.getAttribute("config"))) {
				session.removeAttribute("config");
		%>
		<button id='btn' style='display: none;' class="trigger error-trigger">Error</button>
		<div class="alert alert-success fade in">
			<a href="#" class="close" data-dismiss="alert" aria-label="close">&times;</a>
			<strong>Success!</strong> Beacon configured successfully.
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
		<%
			if (request.getAttribute("beacon") != null && "uuid".equals(request.getAttribute("beacon"))) {
		%>
		<div class="alert alert-danger fade in">
			<strong>Failed!</strong> Beacon UUID not configured. Please configure
			UUID first.
		</div>
		<%
			}
		%>
		<%
			if (request.getAttribute("beacon") != null && "success".equals(request.getAttribute("beacon"))) {
		%>
		<div class="alert alert-success fade in">
			<strong>Success!</strong> Beacon Created.<br>
			Your beacon ID is: <strong><%=request.getAttribute("beaconID") %></strong>
		</div>
		<%
			}
		%>
		<%
			if (request.getAttribute("beacon") != null && "failed".equals(request.getAttribute("beacon"))) {
		%>
		<div class="alert alert-danger fade in">
			<strong>Failed!</strong> Beacon UUID not configured. Please configure
			UUID first.
		</div>
		<%
			}
		%>
		<%
			if (request.getAttribute("beacon") != null && "beaconName".equals(request.getAttribute("beacon"))) {
		%>
		<div class="alert alert-danger fade in">
			<strong>Failed!</strong> Beacon Name already exists.
		</div>
		<%
			}
		%>
		<%
			if (session.getAttribute("token") != null && "failed".equals(session.getAttribute("token"))) {
				session.removeAttribute("token");
		%>
		<div class="alert alert-danger fade in">
			<strong>Invalid token ID!</strong> Token ID does not exists.
		</div>
		<%
			}
		%>
<%
			if (request.getAttribute("beacon") != null && "token".equals(request.getAttribute("beacon"))) {
		%>
		<div class="alert alert-danger fade in">
			<strong>Invalid token ID!</strong> Token ID does not exists.
		</div>
		<%
			}
		%>

		<%
			if (request.getAttribute("count1") != null) {
		%>
		<div class="alert alert-danger fade in">
			<%
				if (request.getAttribute("count1") != null) {
						String count = request.getAttribute("count1").toString();
			%>
			<strong><%=count%></strong> Parameters missing!<br> <br>

			<%
				}
					if (request.getAttribute("msg1") != null) {
			%>
			<strong><%=request.getAttribute("msg1")%></strong><br>
			<%
				}
					if (request.getAttribute("msg2") != null) {
			%>
			<strong><%=request.getAttribute("msg2")%></strong><br>
			<%
				}
					if (request.getAttribute("msg3") != null) {
			%>
			<strong><%=request.getAttribute("msg3")%></strong><br>
			<%
				}
			%>
			
		</div>
		<%
			}
		%>





		<%
			if (request.getAttribute("count") != null) {
		%>
		<div class="alert alert-danger fade in">
			<%
				if (request.getAttribute("count") != null) {
						String count = request.getAttribute("count").toString();
			%>
			<strong><%=count%></strong> Parameters missing!<br> <br>

			<%
				}
					if (request.getAttribute("msg1") != null) {
			%>
			<strong><%=request.getAttribute("msg1")%></strong><br>
			<%
				}
					if (request.getAttribute("msg2") != null) {
			%>
			<strong><%=request.getAttribute("msg2")%></strong><br>
			<%
				}
			%>
		</div>
		<%
			}
		%>
	</div>
</body>
</html>